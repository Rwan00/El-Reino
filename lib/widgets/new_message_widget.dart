import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';

import 'package:el_reino/widgets/app_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/consts.dart';
import '../models/user_model.dart';

class NewMessage extends StatelessWidget {
  final UserData user;
  const NewMessage({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 1,
            bottom: 14,
          ),
          child: Row(
            children: [
              Expanded(
                child: cubit.pickedImage != null && cubit.imgUrl != null
                    ? Container(
                        height: 190,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: FileImage(
                              cubit.pickedImage!,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            onPressed: () {
                              cubit.removeMessageImg();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: primaryBlue,
                            ),
                          ),
                        ),
                      )
                    : AppInputField(
                        hint: "Send Message",
                        controller: messageController,
                        widget: SizedBox(
                          width: 50,
                          child: IconButton(
                            onPressed: () => cubit.fetchImage(),
                            icon: const Icon(Icons.image),
                          ),
                        ),
                      ),
              ),
              IconButton(
                onPressed: () {
                  if (messageController.text.isEmpty && cubit.imgUrl == null) {
                    return;
                  } else {
                    cubit.sendMessage(
                      recieverId: user.uId!,
                      dateTime: DateTime.now().toString(),
                      message: messageController.text.toString(),
                    );
                    messageController.clear();
                  }
                },
                icon: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
