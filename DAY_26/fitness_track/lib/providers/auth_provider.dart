import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _service = AuthService();
  }

  late final AuthService _service;
  UserModel? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Email and password cannot be empty';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final result = await _service.login(email, password);
    _user = result;
    _isAuthenticated = result != null;

    if (!_isAuthenticated) {
      _errorMessage = 'Invalid email or password';
    }

    _isLoading = false;
    notifyListeners();
    return _isAuthenticated;
  }

  /// Register new user with email and password
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Validation
    if (name.isEmpty) {
      _errorMessage = 'Name cannot be empty';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (email.isEmpty || !email.contains('@')) {
      _errorMessage = 'Enter a valid email address';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    if (password.isEmpty || password.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    // Check if email exists
    final exists = await _service.emailExists(email);
    if (exists) {
      _errorMessage = 'Email already registered';
      _isLoading = false;
      notifyListeners();
      return false;
    }

    final result = await _service.register(name, email, password);
    _user = result;
    _isAuthenticated = result != null;

    if (!_isAuthenticated) {
      _errorMessage = 'Registration failed. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
    return _isAuthenticated;
  }

  /// Logout user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await _service.logout();
    _user = null;
    _isAuthenticated = false;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }

  /// Update user profile
  Future<bool> updateProfile(UserModel updatedUser) async {
    _isLoading = true;
    notifyListeners();

    final result = await _service.updateUser(updatedUser);
    if (result != null) {
      _user = result;
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = 'Failed to update profile';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Get current user
  UserModel? getCurrentUser() {
    return _service.getCurrentUser();
  }
}
