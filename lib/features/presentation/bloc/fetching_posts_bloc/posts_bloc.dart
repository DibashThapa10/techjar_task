import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techjar_task/features/data/repo/posts_repository.dart';
import 'package:techjar_task/features/presentation/bloc/fetching_posts_bloc/posts_event.dart';
import 'package:techjar_task/features/presentation/bloc/fetching_posts_bloc/posts_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({required this.postRepository}) : super(PostInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await postRepository.fetchPosts();
        emit(PostLoaded(posts: posts));
      } catch (e) {
        try {
          final cachedPosts = await postRepository.getCachedPosts();
          emit(PostLoaded(posts: cachedPosts));
        } catch (e) {
          emit(PostError(error: 'Failed to fetch posts: $e'));
        }
        
      }
    });
  }
}