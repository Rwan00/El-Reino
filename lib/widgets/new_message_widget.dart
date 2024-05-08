import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/user_model.dart';
import 'input_field.dart';

class NewMessage extends StatelessWidget {
  final UserData user;
  const NewMessage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
            child: Row(
              children: [
                Expanded(
                  child: InputField(
                    hint: "Send Message",
                    controller: messageController,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cubit.sendMessage(
                      recieverId: user.uId!,
                      dateTime: DateTime.now().toString(),
                      message: messageController.text.toString(),
                    );
                    messageController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
