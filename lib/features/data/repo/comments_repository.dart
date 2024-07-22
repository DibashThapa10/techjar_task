import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:techjar_task/core/constants/api.dart';
import 'package:techjar_task/features/data/models/comments_model.dart';

class CommentRepository {
  final Dio _dio = Dio();

  Future<List<CommentsModel>> fetchComments(int postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cachedComments = prefs.getString('cachedComments') ?? '{}';
    final Map<String, dynamic> allComments = json.decode(cachedComments);
    final List<dynamic> commentsForPost = allComments[postId.toString()] ?? [];

   
    if (commentsForPost.isNotEmpty) {
      return commentsForPost
          .map((comment) => CommentsModel.fromJson(comment))
          .toList();
    } else {
      
      final response = await _dio.get('${API.baseUrl}/posts/$postId/comments');
      if (response.statusCode == 200) {
        final comments = (response.data as List)
            .map((comment) => CommentsModel.fromJson(comment))
            .toList();

       
        final Map<String, dynamic> updatedComments = {...allComments};
        updatedComments[postId.toString()] =
            comments.map((comment) => comment.toJson()).toList();
        prefs.setString('cachedComments', json.encode(updatedComments));

        return comments;
      } else {
        throw Exception('Error fetching comments: ${response.data}');
      }
    }
  }
  
  Future<List<CommentsModel>> getCachedComments(int postId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedComments = prefs.getString('cachedComments');
    if (cachedComments != null) {
      final Map<String, dynamic> allComments = json.decode(cachedComments);
      final List<dynamic> commentsForPost =
          allComments[postId.toString()] ?? [];
      return commentsForPost
          .map((comment) => CommentsModel.fromJson(comment))
          .toList();
    }
    throw Exception('No cached data available');
  }

  //posting new comment
  Future<CommentsModel> addComment(
      int postId, String name, String email, String body) async {
    final response = await _dio.post(
      '${API.baseUrl}/posts/$postId/comments',
      data: {
        'postId': postId,
        'name': name,
        'email': email,
        'body': body,
        'userId': 1
      },
    );

    if (response.statusCode == 201) {
      final newComment = CommentsModel.fromJson(response.data);

      // Update cache
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String cachedComments = prefs.getString('cachedComments') ?? '{}';
      final Map<String, dynamic> allComments = json.decode(cachedComments);
      final List<dynamic> commentsForPost =
          allComments[postId.toString()] ?? [];
      commentsForPost.add(response.data); // Add the new comment to the list
      allComments[postId.toString()] = commentsForPost;
      prefs.setString('cachedComments', json.encode(allComments));

      return newComment;
    } else {
      throw Exception('Error adding comment: ${response.data}');
    }
  }
}
