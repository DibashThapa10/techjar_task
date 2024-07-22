import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchComments extends CommentEvent {
  final int postId;

  FetchComments({required this.postId});

  @override
  List<Object> get props => [postId];
}
class AddComment extends CommentEvent {
  final int postId;
  final String name;
  final String email;
  final String body;

  AddComment({
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  List<Object> get props => [postId, name, email, body];
}