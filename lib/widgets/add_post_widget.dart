import 'package:flutter/material.dart';

import '../theme/fonts.dart';

class AddPostWidget extends StatelessWidget {
  const AddPostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey[300],
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://avatars.githubusercontent.com/u/93911923?v=4"),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Share Your Thoughts...",
                style: subTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
