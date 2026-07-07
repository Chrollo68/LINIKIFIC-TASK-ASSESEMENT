import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/bmi_service.dart';
import '../services/workout_routine_service.dart';

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

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Email and password cannot be empty';
      _setLoading(false);
      return false;
    }

    final result = await _service.login(email, password);
    _user = result;
    _isAuthenticated = result != null;

    if (!_isAuthenticated) {
      _errorMessage = 'Please confirm your email before logging in.';
      _setLoading(false);
      return false;
    }

    await _saveMetricsForUser();
    _setLoading(false);
    return true;
  }

  Future<bool> resendConfirmationEmail(String email) async {
    _setLoading(true);
    final sent = await _service.resendConfirmationEmail(email);
    if (sent) {
      _errorMessage = 'Confirmation email sent. Please check your inbox.';
    } else {
      _errorMessage = 'Could not resend confirmation email.';
    }
    _setLoading(false);
    return sent;
  }

  Future<bool> register(String name, String email, String password) async {
    _setLoading(true);
    _errorMessage = null;

    final normalizedName = name.trim();
    final normalizedEmail = email.trim();
    final sanitizedEmail = normalizedEmail.contains('@')
        ? normalizedEmail
        : RegExp(
                r'[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}',
              ).stringMatch(normalizedEmail) ??
              '';

    if (sanitizedEmail.isEmpty || !sanitizedEmail.contains('@')) {
      _errorMessage = 'Enter a valid email address';
      _setLoading(false);
      return false;
    }

    if (password.isEmpty || password.length < 6) {
      _errorMessage = 'Password must be at least 6 characters';
      _setLoading(false);
      return false;
    }

    final result = await _service.register(normalizedName, email, password);
    _user = result;
    _isAuthenticated = result != null;

    if (!_isAuthenticated) {
      _errorMessage = 'Registration failed. Please try again.';
      _setLoading(false);
      return false;
    }

    await _saveMetricsForUser();
    _setLoading(false);
    return true;
  }

  Future<void> logout() async {
    _setLoading(true);
    await _service.logout();
    _user = null;
    _isAuthenticated = false;
    _errorMessage = null;
    _setLoading(false);
  }

  Future<bool> updateProfile(UserModel updatedUser) async {
    _setLoading(true);

    final result = await _service.updateUser(updatedUser);
    if (result != null) {
      _user = result;
      _errorMessage = null;
      await _saveMetricsForUser();
      _setLoading(false);
      return true;
    }

    _errorMessage = 'Failed to update profile';
    _setLoading(false);
    return false;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  UserModel? getCurrentUser() {
    return _service.getCurrentUser();
  }

  BmiMetrics? _metrics;
  BmiMetrics? get metrics => _metrics;

  List<WorkoutRoutine> get recommendedRoutines {
    final bmi = _metrics?.bmi ?? _user?.bmi ?? 0.0;
    return WorkoutRoutineService.instance.getRoutinesForBmi(bmi);
  }

  Future<void> _saveMetricsForUser() async {
    final userKey = _user?.email ?? '';
    if (userKey.isEmpty || _user == null) {
      return;
    }

    await BmiService.instance.saveMetrics(
      userKey,
      weightKg: _user!.weight,
      heightCm: _user!.height,
    );

    _metrics = await BmiService.instance.getMetrics(userKey);
    notifyListeners();
  }

  Future<bool> updateUserMetrics({
    required double height,
    required double weight,
  }) async {
    if (_user == null) return false;

    _user = _user!.copyWith(height: height, weight: weight);
    await _saveMetricsForUser();
    return true;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
