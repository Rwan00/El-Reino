import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/user_widget.dart';
import 'package:flutter/material.dart';

import '../constants/consts.dart';

class UserDetailsScreen extends StatelessWidget {
  final String title;
  final List usersEmails;
  const UserDetailsScreen(
      {required this.title, required this.usersEmails, super.key});

  @override
  Widget build(BuildContext context) {
    List<UserData> users = AppCubit.get(context)
        .users
        .where((element) => usersEmails.contains(element.email))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: appTitle,
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryBlue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: UserWidget(user: users[index]),
        ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: users.length,
      ),
    );
  }
}
