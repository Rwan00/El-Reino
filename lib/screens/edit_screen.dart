import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:el_reino/screens/app_layout.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class EditScreen extends StatelessWidget {
  final UserData userData;
  const EditScreen({required this.userData, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is GetUserSuccessState) {
        buildSnackBar(
          context: context,
          text: "Your Profile Updated Successfully!",
          clr: primaryBlue,
        );
        animatedNavigateAndDelete(
          context: context,
          widget: const SocialAppLayout(),
          direction: PageTransitionType.fade,
          curve: Curves.decelerate,
        );
      }
    }, builder: (context, state) {
      var cubit = AppCubit.get(context);
      nameController.text = userData.name!;
      bioController.text = userData.bio ?? "Add Bio";
      phoneController.text = userData.phone!;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Profile",
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
            state is UpdateUserLoadingState
                ? Image.asset(
                    "assets/loading.gif",
                    height: 95,
                    width: 95,
                  )
                : TextButton.icon(
                    icon: const Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (nameController.text.isEmpty ||
                          bioController.text.isEmpty ||
                          phoneController.text.isEmpty) {
                        buildSnackBar(
                            context: context,
                            text: "Empty Fields!",
                            clr: errorColor,);
                      }
                      else{
                        cubit.updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text,
                      );
                      }
                    },
                    label: Text(
                      "Update",
                      style: titleStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 190,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: GestureDetector(
                          onTap: () => cubit.fetchCoverImage(),
                          child: Stack(
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: cubit.pickedCoverImage != null
                                        ? FileImage(cubit.pickedCoverImage!)
                                        : NetworkImage(
                                            userData.cover ??
                                                "https://i.pinimg.com/564x/01/7c/44/017c44c97a38c1c4999681e28c39271d.jpg",
                                          ) as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (cubit.pickedCoverImage == null)
                                Container(
                                  width: double.infinity,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                  child: Center(
                                    child: CircleAvatar(
                                      backgroundColor: primaryBlue,
                                      child:
                                          const Icon(Icons.camera_alt_outlined),
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GestureDetector(
                          onTap: () => cubit.fetchProfileImage(),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      cubit.pickedProfileImage != null
                                          ? FileImage(cubit.pickedProfileImage!)
                                          : NetworkImage(
                                              userData.image!,
                                            ) as ImageProvider<Object>,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: primaryBlue,
                                child: const Icon(Icons.camera_alt_outlined),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                InputField(
                  hint: "Add UserName",
                  title: "UserName",
                  controller: nameController,
                ),
                InputField(
                  hint: "Add Bio..",
                  title: "Bio",
                  controller: bioController,
                ),
                InputField(
                  hint: "Add Your Phone Number",
                  title: "Phone Number",
                  controller: phoneController,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
