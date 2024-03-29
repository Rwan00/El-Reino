import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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
    return Scaffold(
      backgroundColor: primaryBlue,
      body: Column(
        children: [
          const SizedBox(
            height: 28,
          ),
          Image.asset(
            "assets/logo_sign.png",
            height: 130,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 690,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                            condition:
                                true, //state is! ShopRegisterLoadingState,
                            builder: (context) {
                              return AppBtn(
                                label: "Sign Up",
                                onPressed: () {
                                  /*  if (passwordController.text !=
                              confirmPasswordController.text) {
                            buildSnackBar(
                                context: context,
                                text: "Password Dosen't Match",
                                clr: const Color.fromARGB(255, 92, 1, 1));
                          } else {
                            cubit.userRegister(
                            email: emailController.text,
                            password: passwordController.text,
                            name: usernameController.text,
                            phone: phoneController.text,
                            );
                          } */
                                },
                              );
                            },
                            fallback: (context) => Center(
                              child: Image.asset(
                                "assets/loading.gif",
                                height: 95,
                                width: 95,
                              ),
                            ),
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
          ),
        ],
      ),
    );
  }
}
