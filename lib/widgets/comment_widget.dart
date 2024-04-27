import 'package:el_reino/theme/fonts.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            "https://pbs.twimg.com/profile_images/1708475428044992512/byJNFtW2_400x400.jpg",
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 14,
          ),
          
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.grey[300]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rwan",
                style: titleStyle,
              ),
              Text(
                "Nice PicNice PicNice PicNice PicNice PicNice PicNice PicNice PicNice PicNice PicNice Pic",
                style: titleStyle.copyWith(fontWeight: FontWeight.w100),
                softWrap: true,
              ),
            ],
          ),
        )
      ],
    );
  }
}
