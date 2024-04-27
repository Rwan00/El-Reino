import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/widgets/comment_widget.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:el_reino/widgets/new_comment_widget.dart';
import 'package:el_reino/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;
  final String postId;
  final List likes;

  const PostDetailsScreen(
      {required this.post,
      required this.postId,
      required this.likes,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: primaryBlue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.userData != null,
            builder: (context) {
              return Column(
                children: [
                  PostWidget(
                    post: post,
                    isFeed: false,
                    postId: postId,
                    likes: likes,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return CommentWidget();
                      },
                    ),
                  ),
                  NewCommentWidget(),
                ],
              );
            },
            fallback: (context) {
              return const LoadingWidget();
            },
          ),
        );
      },
    );
  }
}
