import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/post_model.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:el_reino/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/fonts.dart';
import '../widgets/add_post_widget.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.userData != null,
            builder: (context) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(
                    child: AddPostWidget(),
                  ),
                  /*  SliverToBoxAdapter(
                    child: Container(
                      height: 2,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ), */
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 710,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("posts")
                              .snapshots(),
                          builder: (context, snapshot) {
                            print(snapshot.hasData);
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
                                  "No Posts Found!",
                                  style: titleStyle,
                                ),
                              );
                            } else {
                              print("hello?4");
                              print(snapshot.data!.docs[0].data());
                              return ListView.separated(
                                separatorBuilder: (context, index) => Container(
                                  height: 0.5,
                                  width: double.infinity,
                                  color: Colors.grey,
                                ),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final post = PostModel.fromJson(
                                      snapshot.data!.docs[index].data());
                                  final postId = snapshot.data!.docs[index];
                                 
                                  print("pst ${post.likes}");
                                  return PostWidget(
                                    index: index,
                                    likes: List<String>.from(post.likes ?? []),
                                    post: post,
                                    postId: postId.id,
                                    isFeed: true,
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                            }
                          }),
                    ),
                  ),
                ],
              );
            },
            fallback: (context) {
              return const LoadingWidget();
            },
          );
        },
      ),
    );
  }
}
