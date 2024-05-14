import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/models/post_model.dart';
import 'package:el_reino/screens/post_details_screen.dart';
import 'package:el_reino/screens/user_profile_screen.dart';
import 'package:el_reino/screens/view_image.dart';

import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/divide.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../models/user_model.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  final String postId;
  final bool isFeed;
  final List likes;

  final int? index;

  const PostWidget(
      {required this.post,
      required this.isFeed,
      required this.postId,
      required this.likes,
      this.index,
      super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool _isDisposed = false; // Add a variable to track if the widget is disposed

  @override
  void dispose() {
    _isDisposed = true; // Mark the widget as disposed when it is disposed
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLike = false;
  @override
  void initState() {
    super.initState();
    isLike = widget.likes.contains(currentUser.email);
    getCommentsCount();
    print(isLike);
    print(currentUser.email);
    print(widget.likes);
    print(widget.postId);
  }

  void toggleLike() {
    setState(() {
      isLike = !isLike;
    });
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("posts").doc(widget.postId);
    if (isLike) {
      postRef.update({
        "likes": FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        "likes": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  int count = 0;
  getCommentsCount() async {
    var value = await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.postId)
        .collection("Comments")
        .get();
    if (!_isDisposed && mounted) {
      setState(() {
        count = value.docs.length;
      });
    }
    print("Hell${value.docs.length}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        UserData user = cubit.users.firstWhere(
          (user) => user.uId == widget.post.uId,
          orElse: () => cubit.userData!,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
            ),
            elevation: 0,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                            
                            animatedNavigateTo(
                              context: context,
                              widget: UserProfileScreen(user: user),
                              direction: PageTransitionType.leftToRight,
                              curve: Curves.bounceIn,
                            );
                          

                          print(widget.post.uId);
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.post.profileImage!,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.post.name!, style: titleStyle),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (widget.post.isEmailVerified!)
                                  Icon(
                                    Icons.verified,
                                    color: primaryBlue,
                                    size: 16,
                                  ),
                              ],
                            ),
                            Text(widget.post.dateTime!, style: subTitle),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //const Divide(),
                  Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.post.text!,
                          style: titleStyle,
                        ),
                      ),
                    ],
                  ),
                  if (widget.post.image != null)
                    GestureDetector(
                      onTap: () {
                        animatedNavigateTo(
                          context: context,
                          widget: ViewImage(
                            image: widget.post.image!,
                          ),
                          direction: PageTransitionType.rightToLeft,
                          curve: Curves.easeInCirc,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 190,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.post.image!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.isFeed)
                        GestureDetector(
                          onTap: () {
                            toggleLike();
                          },
                          child: isLike
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.black54,
                                ),
                        ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${widget.likes.length.toString()} Likes",
                        style: subTitle,
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          if (widget.isFeed) {
                            animatedNavigateTo(
                              context: context,
                              widget: PostDetailsScreen(
                                index: widget.index!,
                                post: widget.post,
                                postId: widget.postId,
                                likes: widget.likes,
                              ),
                              direction: PageTransitionType.rightToLeft,
                              curve: Curves.easeInCirc,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.comment_outlined,
                          color: Colors.black54,
                        ),
                        label: Text(
                          "$count Comment",
                          style: subTitle,
                        ),
                      ),
                    ],
                  ),
                  const Divide(),
                  if (widget.isFeed)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(cubit.userData!.image!),
                        ),
                        TextButton(
                          onPressed: () {
                            animatedNavigateTo(
                              context: context,
                              widget: PostDetailsScreen(
                                index: widget.index!,
                                post: widget.post,
                                postId: widget.postId,
                                likes: widget.likes,
                              ),
                              direction: PageTransitionType.rightToLeft,
                              curve: Curves.easeInCirc,
                            );
                          },
                          child: Text(
                            "Write a comment...",
                            style: subTitle,
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
