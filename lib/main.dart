import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techjar_task/features/data/repo/comments_repository.dart';
import 'package:techjar_task/features/data/repo/posts_repository.dart';
import 'package:techjar_task/features/presentation/bloc/all_posts_bloc/posts_bloc.dart';
import 'package:techjar_task/features/presentation/bloc/comment_bloc/comment_bloc.dart';

import 'package:techjar_task/features/presentation/pages/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PostBloc>(
              create: (BuildContext context) =>
                  PostBloc(postRepository: PostRepository())),
          BlocProvider<CommentBloc>(
              create: (BuildContext context) =>
                  CommentBloc(commentRepository: CommentRepository()))
        ],
        child: MaterialApp(
            title: 'Tech Jar Task',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const SplashPage()));
  }
}
