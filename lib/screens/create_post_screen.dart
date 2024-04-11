import 'package:el_reino/widgets/app_btn.dart';

import 'package:flutter/material.dart';

import '../theme/fonts.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Post",
          style: heading.copyWith(fontSize: 22, letterSpacing: 0.3),
        ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          /* state is UpdateUserLoadingState
                    ? Image.asset(
                        "assets/loading.gif",
                        height: 95,
                        width: 95,
                      )
                    : */
          TextButton.icon(
            icon: const Icon(
              Icons.post_add_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
            label: Text(
              "Post",
              style: titleStyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/93911923?v=4"),
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  "Rwan",
                  style: titleStyle,
                ),
              ],
            ),
            Expanded(
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "What's on Your Mind?",
                  hintStyle: subTitle,
                  border: InputBorder.none,
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                AppBtn(label: "Add Photo", onPressed: () {}),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.tag_outlined),
                  label: Text(
                    "Add Tags",
                    style: titleStyle,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
