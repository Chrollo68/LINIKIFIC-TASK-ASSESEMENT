import 'package:dio/dio.dart';

import '../storage/token_storage.dart';
import 'api_exception.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio dio = Dio();

  final TokenStorage storage = TokenStorage();

  DioClient() {
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,

      connectTimeout: const Duration(seconds: 10),

      receiveTimeout: const Duration(seconds: 10),

      headers: {"Content-Type": "application/json"},
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        // Runs before every API request
        onRequest: (options, handler) async {
          String? token = await storage.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          handler.next(options);
        },

        // Runs when API gives error
        onError: (DioException error, ErrorInterceptorHandler handler) {
          ApiException exception;

          switch (error.type) {
            case DioExceptionType.connectionTimeout:
              exception = ApiException.timeout();

              break;

            case DioExceptionType.receiveTimeout:
              exception = ApiException.timeout();

              break;

            case DioExceptionType.connectionError:
              exception = ApiException.noInternet();

              break;

            case DioExceptionType.badResponse:
              exception = ApiException.fromResponse(error.response);

              break;

            default:
              exception = ApiException.unknown();
          }

          handler.reject(
            DioException(
              requestOptions: error.requestOptions,

              error: exception,

              type: error.type,

              response: error.response,
            ),
          );
        },
      ),
    );
  }
}
