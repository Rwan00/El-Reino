import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/screens/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/consts.dart';

import '../cubits/app_cubit/app_state.dart';
import '../methods/methods.dart';
import '../models/post_model.dart';
import '../theme/fonts.dart';
import '../widgets/app_btn.dart';
import '../widgets/divide.dart';
import '../widgets/loading_widget.dart';
import '../widgets/post_widget.dart';
import 'edit_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final UserData user;
  const UserProfileScreen({required this.user, super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    isFollow = widget.user.followers.contains(currentUser.email);
    print("followers: ${widget.user.followers}");
    print(isFollow);
  }

  bool isFollow = false;
  final currentUser = FirebaseAuth.instance.currentUser!;

  void toggleFollow() {
    setState(() {
      isFollow = !isFollow;
    });
    DocumentReference userRef =
        FirebaseFirestore.instance.collection("users").doc(widget.user.uId);
    DocumentReference meRef =
        FirebaseFirestore.instance.collection("users").doc(uId);
    if (isFollow) {
      userRef.update({
        "followers": FieldValue.arrayUnion([currentUser.email])
      });
      meRef.update({
        "followings": FieldValue.arrayUnion([widget.user.email])
      });
    } else {
      userRef.update({
        "followers": FieldValue.arrayRemove([currentUser.email])
      });
      meRef.update({
        "followings": FieldValue.arrayRemove([widget.user.email])
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.user.cover ??
                                      "https://i.pinimg.com/564x/01/7c/44/017c44c97a38c1c4999681e28c39271d.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                              widget.user.image,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: widget.user.name.length > 10 ? 200 : null,
                        child: Text(
                          widget.user.name,
                          style: heading,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      if (widget.user.isEmailVerified)
                        Icon(
                          Icons.verified,
                          color: primaryBlue,
                          size: 24,
                        ),
                      const Spacer(),
                      widget.user.uId == uId
                          ? AppBtn(
                              label: "Edit Your Profile",
                              onPressed: () {
                                animatedNavigateTo(
                                  context: context,
                                  widget: EditScreen(
                                    userData: cubit.userData!,
                                  ),
                                  direction: PageTransitionType.bottomToTop,
                                  curve: Curves.decelerate,
                                );
                              },)
                          : AppBtn(
                              label: isFollow ? "Unfollow" : "Follow",
                              onPressed: () {
                                if (widget.user.email ==
                                    "rwanbdalrhym948@gmail.com") {
                                  buildSnackBar(
                                      context: context,
                                      text: "ههههه لا",
                                      clr: errorColor);
                                } else {
                                  toggleFollow();
                                }
                              },
                              clr: isFollow ? Colors.white : null,
                              style: isFollow
                                  ? titleStyle.copyWith(
                                      color: Colors.black,
                                    )
                                  : null,
                            ),
                    ],
                  ),
                  Text(
                    widget.user.bio ?? "",
                    style: subTitle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(widget.user.uId)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        //print("hello?1");
                        return const LoadingWidget();
                      } else if (snapshot.hasError) {
                        //print("hello?2");
                        return Center(
                          child: Text(
                            "Something Went Wrong...",
                            style: titleStyle,
                          ),
                        );
                      } else {
                        final user = UserData.fromJson(snapshot.data!);

                        //print(user.email);
                        return Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    user.posts.length.toString(),
                                    style: titleStyle,
                                  ),
                                  Text(
                                    "Posts",
                                    style: subTitle,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "350",
                                    style: titleStyle,
                                  ),
                                  Text(
                                    "Photos",
                                    style: subTitle,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  animatedNavigateTo(
                                    context: context,
                                    widget: UserDetailsScreen(
                                      title: "Followers",
                                      usersEmails: user.followers,
                                    ),
                                    direction: PageTransitionType.leftToRight,
                                    curve: Curves.easeInCirc,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      user.followers.length.toString(),
                                      style: titleStyle,
                                    ),
                                    Text(
                                      "Followers",
                                      style: subTitle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  animatedNavigateTo(
                                    context: context,
                                    widget: UserDetailsScreen(
                                      title: "Followings",
                                      usersEmails: user.followings,
                                    ),
                                    direction: PageTransitionType.leftToRight,
                                    curve: Curves.easeInCirc,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      user.followings.length.toString(),
                                      style: titleStyle,
                                    ),
                                    Text(
                                      "Followings",
                                      style: subTitle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Divide(),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("posts")
                            .snapshots(),
                        builder: (context, snapshot) {
                          //print(snapshot.hasData);
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            //print("hello?1");
                            return const LoadingWidget();
                          } else if (snapshot.hasError) {
                            //print("hello?2");
                            return Center(
                              child: Text(
                                "Something Went Wrong...",
                                style: titleStyle,
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            //print("hello?3");
                            return Center(
                              child: Text(
                                "No Posts Found!",
                                style: titleStyle,
                              ),
                            );
                          } else {
                            //print("hello?4");
                            //print(snapshot.data!.docs[0].data());
                            List posts = snapshot.data!.docs
                                .where((element) =>
                                    widget.user.posts.contains(element.id))
                                .toList();
                            //print(posts[0].data);
                            return ListView.separated(
                              separatorBuilder: (context, index) => Container(
                                height: 0.5,
                                width: double.infinity,
                                color: Colors.grey,
                              ),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                final post =
                                    PostModel.fromJson(posts[index].data());
                                final postId = posts[index];

                                //print("pst ${post.likes}");
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
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
