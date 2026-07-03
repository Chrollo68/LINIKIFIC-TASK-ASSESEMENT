import 'package:crypto/crypto.dart';
import '../config/supabase_config.dart';
import '../models/user_model.dart';

class AuthService {
  // Local users for fallback/demo mode
  late List<UserModel> _users;

  AuthService() {
    _users = [
      UserModel(
        id: 1,
        name: 'Admin User',
        email: 'admin@gmail.com',
        password: _hashPassword('123456'),
        height: 176,
        weight: 72,
      ),
    ];
  }

  UserModel? currentUser;

  /// Login with email and password - tries Supabase first, then local
  Future<UserModel?> login(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    try {
      // Try Supabase first
      final hashedPassword = _hashPassword(password);
      final response = await SupabaseConfig.client
          .from('users')
          .select()
          .eq('email', email)
          .eq('password', hashedPassword)
          .maybeSingle();

      if (response != null) {
        final user = UserModel.fromJson(response as Map<String, dynamic>);
        currentUser = user;
        return user;
      }
    } catch (e) {
      print('Supabase login error: $e - falling back to local');
    }

    // Fallback to local authentication
    final match = _users
        .where((user) => user.email == email && user.password == password)
        .firstOrNull;
    if (match != null) {
      currentUser = match;
      return match;
    }
    return null;
  }

  /// Register new user - tries Supabase first, then local
  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));

    // Check if email already exists in local or Supabase
    final existsLocal = _users.any((user) => user.email == email);
    if (existsLocal) {
      return null;
    }

    try {
      // Try to register in Supabase
      final hashedPassword = _hashPassword(password);
      final response = await SupabaseConfig.client
          .from('users')
          .insert({'name': name, 'email': email, 'password': hashedPassword})
          .select()
          .single();

      final user = UserModel.fromJson(response as Map<String, dynamic>);
      currentUser = user;
      return user;
    } catch (e) {
      print('Supabase register error: $e - falling back to local');
    }

    // Fallback to local registration
    final newUser = UserModel(
      id: _users.isEmpty
          ? 1
          : (_users.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1),
      name: name,
      email: email,
      password: _hashPassword(password),
    );
    _users.add(newUser);
    currentUser = newUser;
    return newUser;
  }

  /// Logout user
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    currentUser = null;
  }

  /// Get current user
  UserModel? getCurrentUser() {
    return currentUser;
  }

  /// Update user profile
  Future<UserModel?> updateUser(UserModel user) async {
    try {
      // Try Supabase first
      final response = await SupabaseConfig.client
          .from('users')
          .update({'name': user.name, 'email': user.email})
          .eq('id', user.id)
          .select()
          .single();

      final updatedUser = UserModel.fromJson(response as Map<String, dynamic>);
      currentUser = updatedUser;
      return updatedUser;
    } catch (e) {
      print('Supabase update error: $e - falling back to local');
    }

    // Fallback to local update
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      currentUser = user;
      return user;
    }
    return null;
  }

  /// Check if email exists
  Future<bool> emailExists(String email) async {
    // Check local first
    if (_users.any((user) => user.email == email)) {
      return true;
    }

    try {
      // Check Supabase
      final response = await SupabaseConfig.client
          .from('users')
          .select('id')
          .eq('email', email)
          .maybeSingle();

      return response != null;
    } catch (e) {
      print('Email check error: $e');
      return false;
    }
  }

  /// Simple password hashing (use bcrypt in production)
  String _hashPassword(String password) {
    return sha256.convert(password.codeUnits).toString();
  }
}

extension IterableX<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
