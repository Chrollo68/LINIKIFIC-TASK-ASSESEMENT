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

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _service.login(email, password);
    _user = result;
    _isAuthenticated = result != null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final result = await _service.register(name, email, password);
    _user = result;
    _isAuthenticated = result != null;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await _service.logout();
    _user = null;
    _isAuthenticated = false;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateProfile(UserModel updatedUser) async {
    _user = updatedUser;
    notifyListeners();
  }
}
