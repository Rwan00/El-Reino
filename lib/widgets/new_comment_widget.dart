import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/widgets/app_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class NewCommentWidget extends StatelessWidget {
  final String postId;
  const NewCommentWidget({required this.postId, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
   
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
          child: Row(
            children: [
              Expanded(
                child: AppInputField(
                  hint: "Write a Comment...",
                  controller: commentController,
                ),
              ),
              IconButton(
                onPressed: () {
                  cubit.addComment(
                      postId: postId, commentText: commentController.text);
                },
                icon: Icon(
                  Icons.send,
                  color: primaryBlue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
