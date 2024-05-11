import 'package:el_reino/models/comment_model.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentWidget({required this.comment, super.key});

  @override
  Widget build(BuildContext context) {
    String dateString = comment.time;
    final DateTime date = DateTime.parse(dateString);

    final formattedDate = DateFormat('dd,MMMM \'at\' HH:mm').format(date);

    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            comment.image,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.name,
                    style: titleStyle,
                  ),
                  Text(
                    comment.comment,
                    style: titleStyle.copyWith(fontWeight: FontWeight.w100),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            Text(
              formattedDate,
              style: subTitle,
            )
          ],
        )
      ],
    );
  }
}
