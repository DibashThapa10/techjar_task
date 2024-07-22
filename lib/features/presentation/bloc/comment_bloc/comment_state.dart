import 'package:equatable/equatable.dart';
import 'package:techjar_task/features/data/models/comments_model.dart';

abstract class CommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentsModel> comments;

  CommentLoaded({required this.comments});

  @override
  List<Object> get props => [comments];
}

class CommentError extends CommentState {
  final String error;

  CommentError({required this.error});

  @override
  List<Object> get props => [error];
}