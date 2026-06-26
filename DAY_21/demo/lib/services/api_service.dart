import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Fetch a post from the sample API and return the title.
  Future<String> fetchPostTitle() async {
    const url = 'https://jsonplaceholder.typicode.com/posts/1';
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      return response.data['title'] as String? ?? 'No title found';
    }

    throw Exception('Failed to load post');
  }
}
