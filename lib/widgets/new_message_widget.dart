import 'package:el_reino/widgets/app_input_field.dart';
import 'package:flutter/material.dart';

import '../methods/methods.dart';

import '../models/user_model.dart';

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
            child: AppInputField(
              hint: "Send Message",
              controller: messageController,
              widget: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.image),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.map),
                    ),
                  ],
                ),
              ),
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
