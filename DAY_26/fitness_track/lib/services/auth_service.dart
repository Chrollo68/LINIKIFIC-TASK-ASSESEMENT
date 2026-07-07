import 'package:crypto/crypto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/supabase_config.dart';
import '../models/user_model.dart';

class AuthService {
  AuthService();

  static const _userTable = 'users';
  UserModel? currentUser;

  Future<UserModel?> login(String email, String password) async {
    final normalizedEmail = _normalizeEmail(email);
    final normalizedPassword = password.trim();

    if (normalizedEmail.isEmpty || normalizedPassword.isEmpty) {
      return null;
    }

    try {
      final response = await SupabaseConfig.client.auth.signInWithPassword(
        email: normalizedEmail,
        password: normalizedPassword,
      );

      final authUser = response.user;
      if (authUser == null) {
        return _loginWithLocalFallback(normalizedEmail, normalizedPassword);
      }

      try {
        final dbResponse = await SupabaseConfig.client
            .from(_userTable)
            .select()
            .eq('auth_id', authUser.id)
            .single();

        final user = UserModel.fromJson(Map<String, dynamic>.from(dbResponse));
        currentUser = user;
        return user;
      } catch (dbError) {
        return _loginWithLocalFallback(normalizedEmail, normalizedPassword);
      }
    } catch (e) {
      if (e is AuthApiException && _shouldUseLocalFallback(e)) {
        return _loginWithLocalFallback(normalizedEmail, normalizedPassword);
      }

      final message = e.toString();
      if (message.contains('email_not_confirmed')) {
        print('Email confirmation required: $message');
      } else {
        print('Supabase login error: $message');
      }
      return null;
    }
  }

  Future<bool> resendConfirmationEmail(String email) async {
    final normalizedEmail = _normalizeEmail(email);
    if (normalizedEmail.isEmpty) {
      return false;
    }

    try {
      await SupabaseConfig.client.auth.resend(
        type: OtpType.signup,
        email: normalizedEmail,
      );
      return true;
    } catch (e) {
      print('Resend confirmation email error: $e');
      return false;
    }
  }

  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    final normalizedName = name.trim();
    final normalizedEmail = _normalizeEmail(email);
    final normalizedPassword = password.trim();

    if (normalizedName.isEmpty ||
        normalizedEmail.isEmpty ||
        normalizedPassword.isEmpty) {
      return null;
    }

    try {
      final response = await SupabaseConfig.client.auth.signUp(
        email: normalizedEmail,
        password: normalizedPassword,
        data: {'name': normalizedName},
      );

      final authUser = response.user;
      if (authUser == null) {
        return _createOrUpdateLocalUser(
          name: normalizedName,
          email: normalizedEmail,
          password: normalizedPassword,
        );
      }

      return _createOrUpdateLocalUser(
        name: normalizedName,
        email: normalizedEmail,
        password: normalizedPassword,
        authId: authUser.id,
      );
    } catch (e) {
      if (e is AuthApiException && _shouldUseLocalFallback(e)) {
        return _createOrUpdateLocalUser(
          name: normalizedName,
          email: normalizedEmail,
          password: normalizedPassword,
        );
      }

      print('Supabase register error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await SupabaseConfig.client.auth.signOut();
    } catch (e) {
      print('Supabase logout error: $e');
    }
    currentUser = null;
  }

  UserModel? getCurrentUser() {
    return currentUser;
  }

  Future<UserModel?> updateUser(UserModel user) async {
    try {
      final response = await SupabaseConfig.client
          .from(_userTable)
          .update({
            'name': user.name,
            'email': user.email,
            'height': user.height,
            'weight': user.weight,
          })
          .eq('id', user.id)
          .select()
          .single();

      final updatedUser = UserModel.fromJson(
        Map<String, dynamic>.from(response),
      );
      currentUser = updatedUser;
      return updatedUser;
    } catch (e) {
      print('Supabase update error: $e');
      return null;
    }
  }

  Future<bool> emailExists(String email) async {
    final normalizedEmail = _normalizeEmail(email);
    if (normalizedEmail.isEmpty) return false;

    try {
      final response = await SupabaseConfig.client
          .from(_userTable)
          .select('id')
          .eq('email', normalizedEmail)
          .maybeSingle();

      return response != null;
    } catch (e) {
      print('Email exists check error: $e');
      return false;
    }
  }

  Future<UserModel?> _loginWithLocalFallback(
    String email,
    String password,
  ) async {
    try {
      final response = await SupabaseConfig.client
          .from(_userTable)
          .select()
          .eq('email', email)
          .maybeSingle();

      if (response == null) {
        return null;
      }

      final storedPassword = response['password']?.toString();
      if (storedPassword == null || storedPassword != _hashPassword(password)) {
        return null;
      }

      final user = UserModel.fromJson(Map<String, dynamic>.from(response));
      currentUser = user;
      return user;
    } catch (e) {
      print('Local fallback login failed: $e');
      return null;
    }
  }

  Future<UserModel?> _createOrUpdateLocalUser({
    required String name,
    required String email,
    required String password,
    String? authId,
  }) async {
    try {
      final existingResponse = await SupabaseConfig.client
          .from(_userTable)
          .select()
          .eq('email', email)
          .maybeSingle();

      final payload = {
        'name': name,
        'email': email,
        'password': _hashPassword(password),
        if (authId != null) 'auth_id': authId,
        'height': 175,
        'weight': 70,
      };

      final response = existingResponse == null
          ? await SupabaseConfig.client
                .from(_userTable)
                .insert(payload)
                .select()
                .single()
          : await SupabaseConfig.client
                .from(_userTable)
                .update(payload)
                .eq('id', existingResponse['id'])
                .select()
                .single();

      final user = UserModel.fromJson(Map<String, dynamic>.from(response));
      currentUser = user;
      return user;
    } catch (e) {
      print('Local user sync failed: $e');
      return null;
    }
  }

  bool _shouldUseLocalFallback(AuthApiException exception) {
    final code = exception.statusCode?.toString() ?? '';
    final message = exception.message.toLowerCase();
    return code == '400' && message.contains('email not confirmed') ||
        code == '429' && message.contains('rate limit') ||
        message.contains('email_not_confirmed') ||
        message.contains('rate limit');
  }

  String _normalizeEmail(String email) {
    final trimmedEmail = email.trim();
    final extractedEmail = RegExp(
      r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}',
    ).firstMatch(trimmedEmail);

    if (extractedEmail != null) {
      return extractedEmail.group(0)!.trim().toLowerCase();
    }

    return trimmedEmail
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp(r'^\[|\]$'), '')
        .toLowerCase();
  }

  String _hashPassword(String password) {
    return sha256.convert(password.codeUnits).toString();
  }
}
