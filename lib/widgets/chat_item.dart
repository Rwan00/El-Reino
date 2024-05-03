import 'package:el_reino/models/user_model.dart';
import 'package:flutter/material.dart';

import '../theme/fonts.dart';

class ChatItem extends StatelessWidget {
  final UserData user;
  const ChatItem({required this.user,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                user.image!,
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(user.name!, style: titleStyle),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("Hello", style: subTitle),
                ],
              ),
            ),
          ]),
    );
  }
}
