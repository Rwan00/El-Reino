import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/screens/edit_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/consts.dart';
import '../models/user_model.dart';
import '../widgets/app_btn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          print("User:${cubit.userData}");
          return ConditionalBuilder(
            condition: state is GetUserSuccessState,
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 190,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cubit.userData!.cover ??
                                        "https://i.pinimg.com/564x/01/7c/44/017c44c97a38c1c4999681e28c39271d.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  cubit.userData!.image!,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: cubit.userData!.name!.length > 10 ? 200 : null,
                          child: Text(
                            cubit.userData!.name!,
                            style: heading,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        if (cubit.userData!.isEmailVerified!)
                          Icon(
                            Icons.verified,
                            color: primaryBlue,
                            size: 24,
                          ),
                        const Spacer(),
                        AppBtn(
                            label: "Edit Your Profile",
                            onPressed: () {
                              print(cubit.userData?.cover);
                              animatedNavigateTo(
                                context: context,
                                widget: EditScreen(
                                  userData: cubit.userData!,
                                ),
                                direction: PageTransitionType.bottomToTop,
                                curve: Curves.decelerate,
                              );
                            }),
                      ],
                    ),
                    Text(
                      cubit.userData!.bio ?? "Add Bio..",
                      style: subTitle,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(uId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print("hello?1");
                            return LoadingWidget();
                          } else if (snapshot.hasError) {
                            print("hello?2");
                            return Center(
                              child: Text(
                                "Something Went Wrong...",
                                style: titleStyle,
                              ),
                            );
                          } else {
                            final user = UserData.fromJson(snapshot.data!);
                            print(user.email);
                            return Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "500",
                                        style: titleStyle,
                                      ),
                                      Text(
                                        "Posts",
                                        style: subTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "350",
                                        style: titleStyle,
                                      ),
                                      Text(
                                        "Photos",
                                        style: subTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        user.followers!.length.toString(),
                                        style: titleStyle,
                                      ),
                                      Text(
                                        "Followers",
                                        style: subTitle,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        user.followings!.length.toString(),
                                        style: titleStyle,
                                      ),
                                      Text(
                                        "Followings",
                                        style: subTitle,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        })
                  ],
                ),
              );
            },
            fallback: (context) {
              return const LoadingWidget();
            },
          );
        },
      ),
    );
  }
}
