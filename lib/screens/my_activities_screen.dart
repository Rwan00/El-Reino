import 'package:el_reino/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../methods/methods.dart';
import 'my_list_posts_screen.dart';

class MyActivitiesScreen extends StatelessWidget {
  const MyActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Activity",
          style: appTitle,
        ),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              animatedNavigateTo(
                context: context,
                widget: const MyListPostsScreen(
                  typeList: "My posts",
                ),
                direction: PageTransitionType.rightToLeft,
                curve: Curves.easeInCirc,
              );
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode ? Colors.white : Colors.black,
              size: 22,
            ),
            title: Text(
              "My Posts",
              style: titleStyle.copyWith(fontSize: 18),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              animatedNavigateTo(
                context: context,
                widget: const MyListPostsScreen(
                  typeList: "likes",
                ),
                direction: PageTransitionType.rightToLeft,
                curve: Curves.easeInCirc,
              );
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Get.isDarkMode ? Colors.white : Colors.black,
              size: 22,
            ),
            title: Text(
              "My Likes",
              style: titleStyle.copyWith(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
