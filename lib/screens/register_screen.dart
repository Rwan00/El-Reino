import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/cubits/register_cubit/register_cubit.dart';
import 'package:el_reino/cubits/register_cubit/register_state.dart';
import 'package:el_reino/screens/email_verification_screen.dart';
import 'package:el_reino/screens/login_screen.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/consts.dart';
import '../methods/methods.dart';
import '../theme/fonts.dart';
import '../widgets/app_btn.dart';
import '../widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return BlocConsumer<AppRegisterCubit, AppRegisterState>(
      listener: (context, state) {
        if (state is AppRegisterErrorState) {
          buildSnackBar(
            context: context,
            text: state.error,
            clr: errorColor,
          );
        }
        if (state is AppCreateUserErrorState) {
          buildSnackBar(
            context: context,
            text: state.error,
            clr: errorColor,
          );
        }
        if (state is AppCreateUserSuccessState) {
          buildSnackBar(
            context: context,
            text: "Your Register Done Successfully",
            clr: primaryBlue,
          );
          animatedNavigateTo(
            context: context,
            widget: const EmailVerificationScreen(),
            direction: PageTransitionType.bottomToTop,
            curve: Curves.bounceIn,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppRegisterCubit.get(context);
        return Scaffold(
          backgroundColor: primaryBlue,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 52),
              child: Container(
                //height: 820,
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        "Register Account",
                        style: heading,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64.0),
                        child: Text(
                          "Hurry And Be One Of Us",
                          style: subTitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                cubit.pickedImage != null
                                    ? CircleAvatar(
                                        radius: 66,
                                        backgroundImage:
                                            FileImage(cubit.pickedImage!),
                                      )
                                    : const CircleAvatar(
                                        radius: 66,
                                        backgroundImage:
                                            AssetImage("assets/profile.jpg"),
                                      ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor:
                                        Colors.black.withOpacity(0.4),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: cubit.fetchImage,
                                      icon: const Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InputField(
                            title: 'User Name',
                            hint: 'Enter Your Name',
                            controller: usernameController,
                          ),
                          InputField(
                            title: 'Email Address',
                            hint: 'xyz@gmail.com',
                            controller: emailController,
                            textType: TextInputType.emailAddress,
                          ),
                          InputField(
                            title: 'Password',
                            hint: '******',
                            widget: const Icon(Icons.remove_red_eye_outlined),
                            textType: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: passwordController,
                          ),
                          InputField(
                            title: 'Confirm Password',
                            hint: '******',
                            widget: const Icon(Icons.remove_red_eye_outlined),
                            textType: TextInputType.visiblePassword,
                            isPassword: true,
                            controller: confirmPasswordController,
                          ),
                          InputField(
                            title: "Phone",
                            hint: '+20*****',
                            controller: phoneController,
                            textType: TextInputType.phone,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ConditionalBuilder(
                          condition: state is! AppRegisterLoadingState,
                          builder: (context) {
                            return AppBtn(
                              label: "Sign Up",
                              onPressed: () {
                                if (emailController.text.isEmpty ||
                                    usernameController.text.isEmpty ||
                                    passwordController.text.isEmpty ||
                                    phoneController.text.isEmpty) {
                                  buildSnackBar(
                                      context: context,
                                      text: "Please Fill All Fields!",
                                      clr: errorColor);
                                } else if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  buildSnackBar(
                                      context: context,
                                      text: "Password Dosen't Match!",
                                      clr: errorColor);
                                } else if (cubit.pickedImage == null) {
                                  buildSnackBar(
                                      context: context,
                                      text: "The Image Is Empty!",
                                      clr: errorColor);
                                } else {
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: usernameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            );
                          },
                          fallback: (context) => const LoadingWidget(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already Have Account?',
                            style: titleStyle,
                          ),
                          TextButton(
                            onPressed: () {
                              animatedNavigateTo(
                                context: context,
                                widget: const LoginScreen(),
                                direction: PageTransitionType.leftToRight,
                                curve: Curves.easeInCirc,
                              );
                            },
                            child: Text(
                              'Log In',
                              style: subTitle,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
