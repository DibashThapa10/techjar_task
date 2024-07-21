import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techjar_task/core/constants/api.dart';

import 'package:techjar_task/features/data/models/all_posts_model.dart';

class PostRepository {
  final Dio _dio = Dio();
//fetch all posts
  Future<List<PostsModel>> fetchPosts() async {
    final response = await _dio.get('${API.baseUrl}/posts');
    log('response data of posts ${response.statusCode}');
    if (response.statusCode == 200) {
      final posts = (response.data as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();

      // store the data in cache
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('allPosts', json.encode(response.data));

      return posts;
    } else {
      throw Exception('error fetching posts response: ${response.data}');
    }
  }

  Future<List<PostsModel>> getCachedPosts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? allPosts = prefs.getString('allPosts');
    if (allPosts != null) {
      return (json.decode(allPosts) as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();
    }
    throw Exception('No cached data available');
  }
}
