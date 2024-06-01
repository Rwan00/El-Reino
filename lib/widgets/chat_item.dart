import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/screens/chat_content.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../theme/fonts.dart';

class ChatItem extends StatelessWidget {
  final UserData user;
  const ChatItem({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animatedNavigateTo(
          context: context,
          widget: ChatContent(user: user),
          direction: PageTransitionType.leftToRight,
          curve: Curves.easeInCirc,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  user.image,
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
                    Text(user.name, style: titleStyle),
                    const SizedBox(
                      height: 12,
                    ),
                    Text("Hello", style: subTitle),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
