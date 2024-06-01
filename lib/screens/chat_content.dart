import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/chat_messages.dart';

import 'package:el_reino/widgets/new_message_widget.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class ChatContent extends StatelessWidget {
  final UserData user;
  const ChatContent({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(user.image),
                radius: 24,
              ),
              const SizedBox(
                width: 24,
              ),
              Text(
                user.name,
                style: titleStyle,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatMessages(
                user: user,
              ),
            ),
            NewMessage(
              user: user,
            ),
          ],
        ));
  }
}
