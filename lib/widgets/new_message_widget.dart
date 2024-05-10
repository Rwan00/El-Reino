import 'package:flutter/material.dart';

import '../methods/methods.dart';

import '../models/user_model.dart';
import 'input_field.dart';

class NewMessage extends StatelessWidget {
  final UserData user;
  const NewMessage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        right: 1,
        bottom: 14,
      ),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              hint: "Send Message",
              controller: messageController,
            ),
          ),
          IconButton(
            onPressed: () {
              if (messageController.text.isEmpty) {
                return;
              } else {
                sendMessage(
                  recieverId: user.uId!,
                  dateTime: DateTime.now().toString(),
                  message: messageController.text.toString(),
                );
              }
              messageController.clear();
            },
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
