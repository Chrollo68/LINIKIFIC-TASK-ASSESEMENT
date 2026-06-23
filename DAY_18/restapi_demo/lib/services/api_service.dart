import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment.dart';
import '../models/post.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration _timeout = Duration(seconds: 10);

  final Map<String, String> _headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
    'X-Demo-App': 'restapi_demo',
  };

  Uri _buildUri(String path, [Map<String, String>? queryParameters]) {
    return Uri.parse(
      '$_baseUrl$path',
    ).replace(queryParameters: queryParameters);
  }

  Future<List<Post>> fetchPosts({String? searchQuery}) async {
    final queryParameters = <String, String>{'_limit': '40'};
    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      queryParameters['title_like'] = searchQuery.trim();
    }

    final uri = _buildUri('/posts', queryParameters);

    try {
      final response = await http.get(uri, headers: _headers).timeout(_timeout);
      return _parsePostList(response);
    } on TimeoutException {
      throw ApiException('Request timed out. Please try again.');
    } on http.ClientException catch (error) {
      throw ApiException(
        'Network error while fetching posts: ${error.message}',
      );
    } catch (error) {
      throw ApiException('Unexpected error while fetching posts: $error');
    }
  }

  Future<Post> createPost(Post post) async {
    final uri = _buildUri('/posts');
    try {
      final response = await http
          .post(uri, headers: _headers, body: jsonEncode(post.toJson()))
          .timeout(_timeout);
      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      throw ApiException('Failed to create post: ${response.statusCode}');
    } on TimeoutException {
      throw ApiException('Request timed out while creating the post.');
    } on http.ClientException catch (error) {
      throw ApiException(
        'Network error while creating the post: ${error.message}',
      );
    } catch (error) {
      throw ApiException('Unexpected error while creating the post: $error');
    }
  }

  Future<Post> updatePost(Post post) async {
    if (post.id == null) {
      throw ApiException('Post ID is required for update.');
    }

    final uri = _buildUri('/posts/${post.id}');
    try {
      final response = await http
          .put(uri, headers: _headers, body: jsonEncode(post.toJson()))
          .timeout(_timeout);
      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      throw ApiException('Failed to update post: ${response.statusCode}');
    } on TimeoutException {
      throw ApiException('Request timed out while updating the post.');
    } on http.ClientException catch (error) {
      throw ApiException(
        'Network error while updating the post: ${error.message}',
      );
    } catch (error) {
      throw ApiException('Unexpected error while updating the post: $error');
    }
  }

  Future<Post> patchPost(Post post) async {
    if (post.id == null) {
      throw ApiException('Post ID is required for patch.');
    }

    final uri = _buildUri('/posts/${post.id}');
    try {
      final response = await http
          .patch(uri, headers: _headers, body: jsonEncode(post.toJson()))
          .timeout(_timeout);
      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      throw ApiException('Failed to patch post: ${response.statusCode}');
    } on TimeoutException {
      throw ApiException('Request timed out while patching the post.');
    } on http.ClientException catch (error) {
      throw ApiException(
        'Network error while patching the post: ${error.message}',
      );
    } catch (error) {
      throw ApiException('Unexpected error while patching the post: $error');
    }
  }

  Future<void> deletePost(int id) async {
    final uri = _buildUri('/posts/$id');
    try {
      final response = await http
          .delete(uri, headers: _headers)
          .timeout(_timeout);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return;
      }
      throw ApiException('Failed to delete post: ${response.statusCode}');
    } on TimeoutException {
      throw ApiException('Request timed out while deleting the post.');
    } on http.ClientException catch (error) {
      throw ApiException(
        'Network error while deleting the post: ${error.message}',
      );
    } catch (error) {
      throw ApiException('Unexpected error while deleting the post: $error');
    }
  }

  Future<List<Comment>> fetchCommentsForPost(int postId) async {
    final uri = _buildUri('/comments', {'postId': postId.toString()});
    try {
      final response = await http.get(uri, headers: _headers).timeout(_timeout);
      return _parseCommentList(response);
    } on TimeoutException {
      throw ApiException('Request timed out while loading comments.');
    } on http.ClientException catch (error) {
      throw ApiException(
        'Network error while loading comments: ${error.message}',
      );
    } catch (error) {
      throw ApiException('Unexpected error while loading comments: $error');
    }
  }

  List<Post> _parsePostList(http.Response response) {
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((item) => Post.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw ApiException('Failed to load posts: ${response.statusCode}');
  }

  List<Comment> _parseCommentList(http.Response response) {
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((item) => Comment.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    throw ApiException('Failed to load comments: ${response.statusCode}');
  }
}
