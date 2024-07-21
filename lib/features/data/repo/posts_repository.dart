import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:techjar_task/core/constants/api.dart';

import 'package:techjar_task/features/data/models/all_posts_model.dart';

class PostRepository {
  final Dio _dio = Dio();

  Future<List<PostsModel>> fetchPosts() async {
    final response = await _dio.get('${API.baseUrl}/posts');
    log('response data of posts ${response.statusCode}');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();
    } else {
      throw Exception('error fetching posts response: ${response.data}');
    }
  }
}
