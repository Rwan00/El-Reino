import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/screens/chats_screen.dart';
import 'package:el_reino/screens/feeds_screen.dart';
import 'package:el_reino/screens/notification_screen.dart';
import 'package:el_reino/screens/profile_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/drawer.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAppLayout extends StatelessWidget {
  const SocialAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getUserData()
        ..getAllUsers(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          print("User:${cubit.userData}");
          return DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "El Rieno",
                  style: heading.copyWith(color: primaryBlue),
                ),
                actions: [
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/logo.png"),
                        ),
                      ),
                    );
                  })
                ],
                bottom: TabBar(
                  indicatorColor: primaryBlue,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  physics: const BouncingScrollPhysics(),
                  onTap: (index) {
                    cubit.changeTabBar(index);
                  },
                  tabs: <Widget>[
                    Tab(
                      icon: cubit.currentIndex == 0
                          ? Image.asset("assets/home_selected.png")
                          : Image.asset("assets/home.png"),
                    ),
                    Tab(
                      icon: cubit.currentIndex == 1
                          ? Image.asset("assets/chat_selected.png")
                          : Image.asset("assets/chat.png"),
                    ),
                    Tab(
                      icon: cubit.currentIndex == 2
                          ? Image.asset("assets/notification_selected.png")
                          : Image.asset("assets/notification.png"),
                    ),
                    Tab(
                      icon: cubit.currentIndex == 3
                          ? Image.asset("assets/user_selected.png")
                          : Image.asset("assets/avatar.png"),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.userData != null && cubit.users.isNotEmpty,
                builder: (context) {
                  return const TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      FeedsScreen(),
                      ChatsScreen(),
                      NotificationScreen(),
                      ProfileScreen(),
                    ],
                  );
                },
                fallback: (context) {
                  return const LoadingWidget();
                },
              ),
              endDrawer: const MyDrawer(),
              drawerScrimColor: primaryLightTeal.withOpacity(0.3),
            ),
          );
        },
      ),
    );
  }
}
