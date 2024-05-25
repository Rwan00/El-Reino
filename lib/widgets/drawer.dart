import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/screens/user_profile_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/divide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../cubits/theme_cubit/theme_cubit.dart';
import '../helper/cache_helper.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Builder(builder: (context) {
          bool isDark = CacheHelper.getData(key: "isDark");
          return Drawer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  /* Text(
                      "El Rieno",
                      style: heading.copyWith(color: primaryBlue),
                    ), */

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
                      value: isDark,
                      onChanged: (isDark) {
                        cubit.changeAppMode();
                        print(cubit.isDark);
                      },
                    ),
                    leading: const Icon(
                      Icons.dark_mode,
                      size: 28,
                    ),
                    title: Text(
                      "Theme Mode",
                      style: titleStyle.copyWith(fontSize: 22),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.local_activity_outlined,
                      size: 28,
                    ),
                    title: Text(
                      "My Activity",
                      style: titleStyle.copyWith(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
