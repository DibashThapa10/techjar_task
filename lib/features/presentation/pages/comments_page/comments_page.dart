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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.chat_outlined,
            ),
          )
        ],
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
                    child: ListView.separated(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 60,
                        top: 20,
                      ),
                      itemCount: state.comments.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final comment = state.comments[index];
                        return Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${index + 1}. ',
                                        style: const TextStyle(
                                            fontSize: 18, color: Colors.teal),
                                      ),
                                      Expanded(
                                        child: Text(
                                          comment.name!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '@${comment.email}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                  const Divider()
                                ],
                              ),
                              subtitle: Text(
                                comment.body!,
                              ),
                            ),
                          ),
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
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: bodyController,
                          decoration: InputDecoration(
                            labelText: 'Comment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Colors.teal, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2.0),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal),
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
                            }
                          },
                          child: const Text(
                            'Add Comment',
                            style: TextStyle(color: Colors.white),
                          ),
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
