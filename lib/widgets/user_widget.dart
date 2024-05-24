import 'package:el_reino/screens/user_profile_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../methods/methods.dart';
import '../models/user_model.dart';

class UserWidget extends StatelessWidget {
  final UserData user;
  const UserWidget({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        animatedNavigateTo(
          context: context,
          widget: UserProfileScreen(user: user),
          direction: PageTransitionType.leftToRight,
          curve: Curves.easeInCirc,
        );
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(user.image!),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            user.name!,
            style: titleStyle,
          ),
        ],
      ),
    );
  }
}
