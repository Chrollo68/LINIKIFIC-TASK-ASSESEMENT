import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService service = AuthService();

  bool isLoading = false;

  bool loggedIn = false;

  String? errorMessage;

  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      loggedIn = await service.login(email, password);
      isLoading = false;
      notifyListeners();
      return loggedIn;
    } catch (e) {
      errorMessage = e.toString();
      loggedIn = false;
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    isLoading = true;
    errorMessage = null;

    notifyListeners();

    try {
      final success = await service.register(name, email, password);
      if (success) {
        loggedIn = true;
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception("Registration failed");
      }
    } catch (e) {
      errorMessage = e.toString();
      loggedIn = false;
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await service.logout();
    loggedIn = false;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> checkAuth() async {
    loggedIn = await service.checkLogin();
    notifyListeners();
  }
}
