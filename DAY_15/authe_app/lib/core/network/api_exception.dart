class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() {
    return message;
  }

  // Factory constructor for creating
  // exceptions from API responses

  factory ApiException.fromResponse(dynamic response) {
    String message = "Something went wrong";

    int? code;

    if (response != null) {
      code = response.statusCode;

      if (response.data is Map && response.data["message"] != null) {
        message = response.data["message"];
      } else if (response.data is Map && response.data["error"] != null) {
        message = response.data["error"];
      } else {
        switch (code) {
          case 400:
            message = "Bad request";
            break;

          case 401:
            message = "Unauthorized. Please login again";
            break;

          case 403:
            message = "Access denied";
            break;

          case 404:
            message = "Resource not found";
            break;

          case 500:
            message = "Internal server error";
            break;

          default:
            message = "Request failed";
        }
      }
    }

    return ApiException(message, statusCode: code);
  }

  // Network error helpers

  static ApiException noInternet() {
    return ApiException("No internet connection");
  }

  static ApiException timeout() {
    return ApiException("Request timeout");
  }

  static ApiException unknown() {
    return ApiException("Unexpected error occurred");
  }
}
