import 'package:el_reino/constants/consts.dart';
import 'package:flutter/material.dart';

import 'input_field.dart';

class NewCommentWidget extends StatelessWidget {
  const NewCommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: InputField(
              hint: "Write a Comment...",
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
