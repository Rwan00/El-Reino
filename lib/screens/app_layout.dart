import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/screens/chats_screen.dart';
import 'package:el_reino/screens/feeds_screen.dart';
import 'package:el_reino/screens/notification_screen.dart';
import 'package:el_reino/screens/profile_screen.dart';
import 'package:el_reino/theme/fonts.dart';
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
        ..getAllUsers()
        ,
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
                backgroundColor: Colors.white,
                title: Text(
                  "El Rieno",
                  style: heading.copyWith(color: primaryBlue),
                ),
                actions: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                    ),
                  )
                ],
                bottom: TabBar(
                 
                  tabs: <Widget>[
                    Tab(
                      icon: Image.asset("assets/home.png"),
                    ),
                    Tab(
                      icon: Image.asset("assets/chat.png"),
                    ),
                    Tab(
                      icon: Image.asset("assets/notification.png"),
                    ),
                    Tab(
                      icon: Image.asset("assets/avatar.png"),
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: cubit.userData != null && cubit.users.isNotEmpty,
                builder: (context) {
                  return const TabBarView(
                    physics: PageScrollPhysics(),
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
            ),
          );
        },
      ),
    );
  }
}
