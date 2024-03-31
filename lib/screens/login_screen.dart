import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:el_reino/cubits/login_cubit/login_cubit.dart';
import 'package:el_reino/cubits/login_cubit/login_state.dart';
import 'package:el_reino/methods/methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../theme/fonts.dart';
import '../widgets/app_btn.dart';
import '../widgets/input_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => AppLoginCubit(),
      child: BlocConsumer<AppLoginCubit, AppLoginState>(
        listener: (context, state) {
          if (state is AppLoginErrorState) {
            buildSnackBar(context: context, text: state.error, clr: errorColor);
          }
        },
        builder: (context, state) {
          var cubit = AppLoginCubit.get(context);
          return Scaffold(
            backgroundColor: const Color.fromRGBO(0, 141, 218, 1),
            body: Column(
              children: [
                const SizedBox(
                  height: 58,
                ),
                Center(
                  child: Image.asset(
                    "assets/logo_sign.png",
                    height: 260,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                "Hello Again!",
                                style: heading,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 64.0),
                                child: Text(
                                  "Please SignIn To Continue",
                                  style: subTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InputField(
                                    title: 'Email Address',
                                    hint: 'xyz@gmail.com',
                                    controller: emailController,
                                    textType: TextInputType.emailAddress,
                                  ),
                                  InputField(
                                    title: 'Password',
                                    hint: '******',
                                    isPassword: true,
                                    textType: TextInputType.visiblePassword,
                                    controller: passwordController,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Forgot Password?",
                                      style: subTitle,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: ConditionalBuilder(
                                  condition: state is! AppLoginLoadingState,
                                  builder: (context) => AppBtn(
                                    label: 'Sign In',
                                    onPressed: () {
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    },
                                  ),
                                  fallback: (context) => Center(
                                    child: Image.asset(
                                      "assets/loading.gif",
                                      height: 95,
                                      width: 95,
                                    ),
                                  ),
                                ),
                              ),
                              // const Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'New User?',
                                    style: titleStyle,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      animatedNavigateTo(
                                        context: context,
                                        widget: const RegisterScreen(),
                                        direction:
                                            PageTransitionType.rightToLeft,
                                        curve: Curves.easeInCirc,
                                      );
                                    },
                                    child: Text(
                                      'Create Account',
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
