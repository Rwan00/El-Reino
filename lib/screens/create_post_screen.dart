import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/widgets/app_btn.dart';
import 'package:el_reino/widgets/loading_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/consts.dart';
import '../methods/methods.dart';
import '../theme/fonts.dart';
import 'app_layout.dart';

class CreatePost extends StatelessWidget {
  final UserData userData;
  const CreatePost({required this.userData, super.key});
  

  @override
  Widget build(BuildContext context) {
    TextEditingController postController = TextEditingController();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      AppCubit.get(context).getUserData();
    });
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is CreatePostSuccessState) {
          buildSnackBar(
            context: context,
            text: "Your Post Uploaded Successfully!",
            clr: primaryBlue,
          );
          animatedNavigateAndDelete(
            context: context,
            widget: const SocialAppLayout(),
            direction: PageTransitionType.fade,
            curve: Curves.bounceIn,
          );
        }
        if (state is CreatePostErrorState) {
          buildSnackBar(
            context: context,
            text: state.error,
            clr: errorColor,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        
        print("create post user: ${cubit.userData}");
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create Post",
              style: heading.copyWith(fontSize: 22, letterSpacing: 0.3),
            ),
            leading: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              state is CreatePostLoadingState
                  ? const LoadingWidget()
                  : TextButton.icon(
                      icon: Icon(
                        Icons.post_add_outlined,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        if (postController.text.isEmpty &&
                            cubit.postImgUrl == null) {
                          buildSnackBar(
                            context: context,
                            text: "Empty Post!",
                            clr: errorColor,
                          );
                        } else {
                          cubit.createNewPost(text: postController.text);
                        }
                      },
                      label: Text(
                        "Post",
                        style: titleStyle,
                      ),
                    ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        userData.image,
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Text(
                      userData.name,
                      style: titleStyle,
                    ),
                  ],
                ),
                Expanded(
                  child: TextField(
                    maxLines: 10,
                    controller: postController,
                    style: titleStyle,
                    decoration: InputDecoration(
                      hintText: "What's on Your Mind?",
                      hintStyle: subTitle,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (cubit.postImgUrl != null)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(
                          cubit.pickedPostImage!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: IconButton(
                        onPressed: () {
                          cubit.removePostImg();
                        },
                        icon: Icon(
                          Icons.cancel,
                          color: primaryBlue,
                        ),
                      ),
                    ),
                  ),
                const Spacer(),
                Row(
                  children: [
                    AppBtn(
                        label: "Add Photo",
                        onPressed: () {
                          cubit.fetchPostImage();
                        }),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.tag_outlined),
                      label: Text(
                        "Add Tags",
                        style: titleStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
