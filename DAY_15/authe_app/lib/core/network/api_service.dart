import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiService {
  final Dio dio = DioClient().dio;

  Future<Response> login(String email, String password) async {
    return await dio.post(
      "/auth/login",
      data: {"email": email, "password": password},
    );
  }

  Future<Response> register(String name, String email, String password) async {
    return await dio.post(
      "/auth/register",
      data: {"name": name, "email": email, "password": password},
    );
  }
}
