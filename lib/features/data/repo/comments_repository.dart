import 'package:dio/dio.dart';
import 'package:techjar_task/features/data/models/comments_model.dart';

class CommentRepository {
  final Dio _dio = Dio();

  Future<List<CommentsModel>> fetchComments(int postId) async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/posts/$postId/comments');
    return (response.data as List).map((json) => CommentsModel.fromJson(json)).toList();
  }
}