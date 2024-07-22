import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techjar_task/features/presentation/bloc/all_posts_bloc/posts_bloc.dart';
import 'package:techjar_task/features/presentation/bloc/all_posts_bloc/posts_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech Jar Task'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.separated(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 60,
                top: 20,
              ),
              itemCount: state.posts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return InkWell(
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      child: ListTile(
                        leading: Text(
                          '${index + 1}. ',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.teal),
                        ),
                        title: Text(post.title!),
                        iconColor: Colors.teal,
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_outlined),
                        // subtitle: Text(post.body!),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return Center(child: Text('Failed to fetch posts: ${state.error}'));
          }
          return const Center(child: Text('No posts'));
        },
      ),
    );
  }
}
