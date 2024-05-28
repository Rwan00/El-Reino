import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/post_model.dart';
import '../theme/fonts.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_widget.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Saved Posts",
              style: appTitle,
            ),
          ),
          body: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (snapshot.connectionState == ConnectionState.waiting) {
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
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
                  print(cubit.userData!.posts);
                  List posts = snapshot.data!.docs
                      .where((element) =>
                          cubit.userData!.savedPosts!.contains(element.id))
                      .toList();
                  print(posts[0].data);
                  return ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 0.5,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final post = PostModel.fromJson(posts[index].data());
                      final postId = posts[index];

                      print("pst ${post.uId}");
                      return PostWidget(
                        index: index,
                        likes: List<String>.from(post.likes ?? []),
                        post: post,
                        postId: postId.id,
                        isFeed: true,
                      );
                    },
                    itemCount: posts.length,
                  );
                }
              }),
        );
      },
    );
  }
}
