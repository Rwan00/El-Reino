import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/screens/app_layout.dart';
import 'package:el_reino/screens/my_activities_screen.dart';
import 'package:el_reino/screens/my_list_posts_screen.dart';

import 'package:el_reino/screens/user_profile_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/divide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Drawer(
          backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(cubit.userData!.image!),
                  ),
                  title: Text(
                    cubit.userData!.name!,
                    style: appTitle,
                  ),
                  subtitle: Text(
                    cubit.userData!.bio!,
                    style: subTitle,
                  ),
                  onTap: () {
                    animatedNavigateTo(
                      context: context,
                      widget: UserProfileScreen(user: cubit.userData!),
                      direction: PageTransitionType.fade,
                      curve: Curves.bounceInOut,
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divide(),
                ),
                ListTile(
                  trailing: Switch(
                    activeColor: primaryBlue,
                    activeTrackColor: primaryLightTeal,
                    inactiveTrackColor: Colors.grey,
                    value: cubit.loadThemeFromBox(),
                    onChanged: (isDark) {
                      cubit.switchTheme();
                      animatedNavigateAndDelete(
                        context: context,
                        widget: const SocialAppLayout(),
                        direction: PageTransitionType.fade,
                        curve: Curves.decelerate,
                      );
                    },
                  ),
                  leading: Icon(
                    Icons.dark_mode,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    size: 22,
                  ),
                  title: Text(
                    "Dark Mode",
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
                      widget: const MyActivitiesScreen(),
                      direction: PageTransitionType.rightToLeft,
                      curve: Curves.easeInCirc,
                    );
                  },
                  leading: Icon(
                    Icons.local_activity_outlined,
                    size: 22,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "My Activity",
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
                        typeList: "saved posts",
                      ),
                      direction: PageTransitionType.rightToLeft,
                      curve: Curves.easeInCirc,
                    );
                  },
                  leading: Icon(
                    Icons.save_alt_outlined,
                    size: 22,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    "Save Posts",
                    style: titleStyle.copyWith(fontSize: 18),
                  ),
                ),
                const Spacer(),
                
                const Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  onTap: () => buildDialog(
                    context: context,
                    title: "Log Out",
                    message: "Are Sure You Want To Log Out?",
                    onPressed: () {
                      signOut(context);
                      Navigator.of(context).pop();
                    },
                    btnTxt: "Logout",
                  ),
                  leading: const Icon(
                    Icons.exit_to_app,
                    size: 22,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Log Out",
                    style: titleStyle.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
