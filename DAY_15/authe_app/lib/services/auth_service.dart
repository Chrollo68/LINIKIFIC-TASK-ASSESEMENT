import 'package:dio/dio.dart';

import '../core/network/api_service.dart';
import '../core/storage/token_storage.dart';

class AuthService {
  final ApiService api = ApiService();

  final TokenStorage storage = TokenStorage();

  Future<bool> login(String email, String password) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        throw Exception("Email and password are required");
      }

      final response = await api.login(email, password);
      final token = _extractToken(response.data);

      if (token == null) {
        throw Exception("Invalid response from server");
      }

      await storage.saveToken(token);
      return true;
    } on DioException catch (e) {
      throw Exception(e.message ?? "Login failed");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception("All fields are required");
      }

      final response = await api.register(name, email, password);
      final token = _extractToken(response.data);

      if (token == null) {
        throw Exception("Invalid response from server");
      }

      await storage.saveToken(token);
      return true;
    } on DioException catch (e) {
      throw Exception(e.message ?? "Registration failed");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  String? _extractToken(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data["token"] != null) {
        return data["token"].toString();
      }
      if (data["data"] is Map<String, dynamic>) {
        final nested = data["data"] as Map<String, dynamic>;
        if (nested["token"] != null) {
          return nested["token"].toString();
        }
      }
    }
    return null;
  }

  Future<void> logout() async {
    await storage.deleteToken();
  }

  Future<bool> checkLogin() async {
    String? token = await storage.getToken();

    return token != null;
  }
}
