import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techjar_task/features/data/repo/comments_repository.dart';
import 'package:techjar_task/features/presentation/bloc/comment_bloc/comment_event.dart';
import 'package:techjar_task/features/presentation/bloc/comment_bloc/comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepository;

  CommentBloc({required this.commentRepository}) : super(CommentInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await commentRepository.fetchComments(event.postId);
        emit(CommentLoaded(comments: comments));
      } catch (e) {
        // try {
        //   final cachedComments =
        //       await commentRepository.getCachedComments(event.postId);
        //   emit(CommentLoaded(comments: cachedComments));
        // } catch (e) {
        emit(CommentError(error: 'Failed to fetch comments: $e'));
        // }
      }
    });
    on<AddComment>((event, emit) async {
      emit(CommentLoading());
      try {
        await commentRepository.addComment(
          event.postId,
          event.name,
          event.email,
          event.body,
        );

        final comments = await commentRepository.fetchComments(event.postId);
        // comments.add(newComment);
        // emit(CommentAdded());

        emit(CommentLoaded(comments: comments));
      } catch (e) {
        emit(CommentError(error: 'Failed to add comment: $e'));
      }
    });
  }
}
