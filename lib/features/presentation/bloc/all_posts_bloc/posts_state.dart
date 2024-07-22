import 'package:equatable/equatable.dart';
import 'package:techjar_task/features/data/models/all_posts_model.dart';

abstract class PostState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostsModel> posts;

  PostLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

class PostError extends PostState {
  final String error;

  PostError({required this.error});

  @override
  List<Object> get props => [error];
}