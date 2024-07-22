import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techjar_task/features/data/repo/comments_repository.dart';
import 'package:techjar_task/features/presentation/bloc/comment_bloc/comment_bloc.dart';
import 'package:techjar_task/features/presentation/bloc/comment_bloc/comment_event.dart';
import 'package:techjar_task/features/presentation/bloc/comment_bloc/comment_state.dart';

class CommentPage extends StatelessWidget {
  final int? postId;
  const CommentPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
        backgroundColor: Colors.teal,
      ),
      body: BlocProvider(
        create: (context) => CommentBloc(commentRepository: CommentRepository())
          ..add(FetchComments(postId: postId ?? 0)),
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommentLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.comments.length,
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return ListTile(
                          title: Text(comment.name!),
                          subtitle: Text(comment.body!),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(labelText: 'Name'),
                        ),
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: bodyController,
                          decoration:
                              const InputDecoration(labelText: 'Comment'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final String name = nameController.text;
                            final String email = emailController.text;
                            final String body = bodyController.text;

                            if (name.isNotEmpty &&
                                email.isNotEmpty &&
                                body.isNotEmpty) {
                              context.read<CommentBloc>().add(AddComment(
                                    postId: postId!,
                                    name: name,
                                    email: email,
                                    body: body,
                                  ));
                              // Navigator.pop(context);
                            }
                          },
                          child: const Text('Add Comment'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is CommentError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('No comments'));
          },
        ),
      ),
      
    );
  }

  
}
