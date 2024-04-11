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
                    : */ TextButton.icon(
                        icon: const Icon(
                          Icons.post_add_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          
                        },
                        label: Text(
                          "Post",
                          style: titleStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
    );
  }
}