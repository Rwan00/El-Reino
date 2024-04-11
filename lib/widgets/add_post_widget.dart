import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/screens/create_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../theme/fonts.dart';

class AddPostWidget extends StatelessWidget {
  const AddPostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return GestureDetector(
          onTap: () {
            animatedNavigateTo(
              context: context,
              widget: const CreatePost(),
              direction: PageTransitionType.bottomToTop,
              curve: Curves.decelerate,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: Row(
                children: [
                   CircleAvatar(
                    backgroundImage: NetworkImage(
                        cubit.userData!.image!,),
                  ),
                  Text(
                    "Share Your Thoughts...",
                    style: subTitle,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
