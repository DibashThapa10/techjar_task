import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techjar_task/features/presentation/bloc/fetching_posts_bloc/posts_bloc.dart';
import 'package:techjar_task/features/presentation/bloc/fetching_posts_bloc/posts_event.dart';
import 'package:techjar_task/features/presentation/pages/home_page/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3, milliseconds: 500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    _controller.forward();
    _controller.repeat();
    super.initState();
    BlocProvider.of<PostBloc>(context).add(FetchPosts());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/logo.png",
                    ),
                    fit: BoxFit.fill)),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  color: Colors.teal,
                  strokeWidth: 3.0,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Version 1.0',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.white),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
