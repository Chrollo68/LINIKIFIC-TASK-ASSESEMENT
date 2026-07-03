import 'package:crypto/crypto.dart';
import '../config/supabase_config.dart';
import '../models/user_model.dart';

class SupabaseAuthService {
  SupabaseAuthService();

  UserModel? currentUser;

  /// Register a new user with email and password
  Future<UserModel?> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      // Hash the password (in production, use proper password hashing)
      final hashedPassword = _hashPassword(password);

      // Insert user into database
      final response = await SupabaseConfig.client
          .from('users')
          .insert({'name': name, 'email': email, 'password': hashedPassword})
          .select()
          .single();

      final user = UserModel.fromJson(response as Map<String, dynamic>);
      currentUser = user;
      return user;
    } catch (e) {
      print('Register error: $e');
      return null;
    }
  }

  /// Login user with email and password
  Future<UserModel?> login(String email, String password) async {
    try {
      final hashedPassword = _hashPassword(password);

      final response = await SupabaseConfig.client
          .from('users')
          .select()
          .eq('email', email)
          .eq('password', hashedPassword)
          .single();

      final user = UserModel.fromJson(response as Map<String, dynamic>);
      currentUser = user;
      return user;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  /// Get current user
  UserModel? getCurrentUser() {
    return currentUser;
  }

  /// Update user profile
  Future<UserModel?> updateUser(UserModel user) async {
    try {
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
      print('Update user error: $e');
      return null;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      currentUser = null;
    } catch (e) {
      print('Logout error: $e');
    }
  }

  /// Check if email already exists
  Future<bool> emailExists(String email) async {
    try {
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

  /// Simple password hashing (use bcrypt or similar in production)
  String _hashPassword(String password) {
    return sha256.convert(password.codeUnits).toString();
  }
}
