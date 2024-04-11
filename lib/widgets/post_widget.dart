import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/post_model.dart';

import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/divide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:like_button/like_button.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;

  const PostWidget({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Card(
            color: Colors.white,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          post.profileImage!,
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
                                Text(post.name!, style: titleStyle),
                                const SizedBox(
                                  width: 5,
                                ),
                                if (post.isEmailVerified!)
                                  Icon(
                                    Icons.verified,
                                    color: primaryBlue,
                                    size: 16,
                                  ),
                              ],
                            ),
                            Text(post.dateTime!, style: subTitle),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 28,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  const Divide(),
                  Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.text!,
                            style: titleStyle,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Wrap(
                              children: [
                                SizedBox(
                                  height: 25,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 25,
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "#software",
                                      style: subTitle.copyWith(
                                        color: primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 25,
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "#software",
                                      style: subTitle.copyWith(
                                        color: primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 25,
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "#software",
                                      style: subTitle.copyWith(
                                        color: primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                  child: MaterialButton(
                                    onPressed: () {},
                                    height: 25,
                                    minWidth: 1,
                                    padding: EdgeInsets.zero,
                                    child: Text(
                                      "#software",
                                      style: subTitle.copyWith(
                                        color: primaryBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  if (post.image != null)
                    Container(
                      height: 190,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                            post.image!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LikeButton(
                        size: 24,
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            isLiked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            size: 24,
                            color: isLiked ? Colors.redAccent : Colors.black54,
                          );
                        },
                        likeCount: 900,
                        bubblesColor: BubblesColor(
                            dotPrimaryColor: primaryBlue,
                            dotSecondaryColor: lightBlue),
                        circleColor:
                            CircleColor(start: primaryBlue, end: lightBlue),
                      ),
                      const Spacer(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.comment_outlined,
                          color: Colors.black54,
                        ),
                        label: Text(
                          "2000 comment",
                          style: subTitle,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.ios_share_outlined,
                          color: Colors.black54,
                        ),
                        label: Text(
                          "200",
                          style: subTitle,
                        ),
                      ),
                    ],
                  ),
                  const Divide(),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(cubit.userData!.image!),
                      ),
                      TextButton(
                        onPressed: () {},
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
