import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/screens/chats_screen.dart';
import 'package:el_reino/screens/feeds_screen.dart';
import 'package:el_reino/screens/notification_screen.dart';
import 'package:el_reino/screens/settings_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:flutter/material.dart';

class SocialAppLayout extends StatelessWidget {
  const SocialAppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child:  Scaffold(
        appBar: AppBar(
          title:  Text("El Rieno",style: heading.copyWith(color: primaryBlue),),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/logo.png"),
              ),
            )
          ],
          bottom:  TabBar(
            tabs: <Widget>[
              Tab(icon: Image.asset("assets/home.png"),),
              Tab(icon: Image.asset("assets/chat.png"),),
              Tab(icon: Image.asset("assets/notification.png"),),
              Tab(icon: Image.asset("assets/setting.png"),),  
            ],
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            FeedsScreen(),
            ChatsScreen(),
            NotificationScreen(),
            SettingsScreen(),
          ],
        ),
      ),
    );
  }
}
