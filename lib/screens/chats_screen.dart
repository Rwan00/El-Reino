import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/widgets/chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/divide.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<UserData> users = cubit.users.where((element) => element.uId != uId && cubit.userData!.followers.contains(element.email)).toList();
       
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => ChatItem(
            user: users[index],
          ),
          separatorBuilder: (context, index) => const Divide(),
          itemCount: users.length,
        );
      },
    );
  }
}
