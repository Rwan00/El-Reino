import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/consts.dart';
import '../methods/methods.dart';
import '../theme/fonts.dart';
import '../widgets/app_btn.dart';

class UserProfileScreen extends StatelessWidget {
  final UserData user;
  const UserProfileScreen({required this.user,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 190,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            user.cover ??
                                "https://i.pinimg.com/564x/01/7c/44/017c44c97a38c1c4999681e28c39271d.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          user.image!,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  user.name!,
                  style: heading,
                ),
                if (user.isEmailVerified!)
                  Icon(
                    Icons.verified,
                    color: primaryBlue,
                    size: 24,
                  ),
                const Spacer(),
                AppBtn(
                    label: "Edit Your Profile",
                    onPressed: () {
                     
                      animatedNavigateTo(
                        context: context,
                        widget: EditScreen(
                          userData: user,
                        ),
                        direction: PageTransitionType.bottomToTop,
                        curve: Curves.decelerate,
                      );
                    }),
              ],
            ),
            Text(
              user.bio ?? "Add Bio..",
              style: subTitle,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "500",
                        style: titleStyle,
                      ),
                      Text(
                        "Posts",
                        style: subTitle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "350",
                        style: titleStyle,
                      ),
                      Text(
                        "Photos",
                        style: subTitle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "100K",
                        style: titleStyle,
                      ),
                      Text(
                        "Followers",
                        style: subTitle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "367",
                        style: titleStyle,
                      ),
                      Text(
                        "Followings",
                        style: subTitle,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
