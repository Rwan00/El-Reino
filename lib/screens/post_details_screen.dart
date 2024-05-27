import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/comment_model.dart';
import 'package:el_reino/widgets/comment_widget.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:el_reino/widgets/new_comment_widget.dart';
import 'package:el_reino/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import '../theme/fonts.dart';

class PostDetailsScreen extends StatelessWidget {
  final PostModel post;
  final String postId;
  final List likes;
  final int index;

  const PostDetailsScreen(
      {required this.post,
      required this.postId,
      required this.likes,
      super.key,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Scaffold(
          appBar: AppBar(
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
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .doc(postId)
                            .collection("Comments")
                            .orderBy("time")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print("hello?1");
                            return LoadingWidget();
                          } else if (snapshot.hasError) {
                            print("hello?2");
                            return Center(
                              child: Text(
                                "Something Went Wrong...",
                                style: titleStyle,
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            print("hello?3");
                            return Center(
                              child: Text(
                                "No Comments Found!",
                                style: titleStyle,
                              ),
                            );
                          } else {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final comment = CommentModel.fromJson(
                                    snapshot.data!.docs[index].data());

                                return CommentWidget(
                                  comment: comment,
                                );
                              },
                            );
                          }
                        }),
                  ),
                  NewCommentWidget(
                    postId: postId,
                  ),
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
