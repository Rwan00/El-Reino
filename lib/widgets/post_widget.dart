import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/divide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';

import '../cubits/app_cubit/app_cubit.dart';

class PostWidget extends StatefulWidget {
  
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
   bool flag = true;
  void readMore() {
   setState(() {
      flag = !flag;
   });
   
  }
  @override
  Widget build(BuildContext context) {
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
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/93911923?v=4"),
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
                                  Text("Rwan", style: titleStyle),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.verified,
                                    color: primaryBlue,
                                    size: 16,
                                  )
                                ],
                              ),
                              Text("Jan 22,2024 at 11:00 pm", style: subTitle),
                            ]),
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
                        children: [
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                            style: titleStyle,
                            maxLines: flag ? 3 : null,
                            overflow: flag ? TextOverflow.ellipsis : null,
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
                      InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              flag ? "Show More.." : "Show Less",
                              style: titleStyle.copyWith(color: primaryBlue),
                            ),
                          ],
                        ),
                        onTap: () {
                          readMore();
                        },
                      ),
                    ],
                  ),
                  Container(
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://pbs.twimg.com/media/GKcSxC6WoAAm7bb?format=jpg&name=small"),
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
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/93911923?v=4"),
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
  }
}
