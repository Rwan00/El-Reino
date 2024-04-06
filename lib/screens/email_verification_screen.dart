import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/register_cubit/register_cubit.dart';
import 'package:el_reino/cubits/register_cubit/register_state.dart';
import 'package:el_reino/methods/methods.dart';

import 'package:el_reino/screens/login_screen.dart';
import 'package:el_reino/theme/fonts.dart';
import 'package:el_reino/widgets/app_btn.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppRegisterCubit, AppRegisterState>(
      listener: (context, state) {
        if (state is VerifyEmailErrorState) {
          buildSnackBar(context: context, text: state.error, clr: errorColor);
        }
        if (state is VerifyEmailSuccessState) {
          buildSnackBar(
        context: context,
        text: "Please Check Your Email",
        clr: primaryBlue,
      );
          animatedNavigateAndDelete(
            context: context,
            widget: const LoginScreen(),
            direction: PageTransitionType.fade,
            curve: Curves.bounceIn,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppRegisterCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/email.jpg",
                  height: 320,
                  width: 320,
                ),
                Text(
                  "Please Verify Your Email",
                  style: titleStyle,
                ),
                state is VerifyEmailLoadingState
                    ? Center(
                        child: Image.asset(
                          "assets/loading.gif",
                          height: 95,
                          width: 95,
                        ),
                      )
                    : AppBtn(
                        label: "Send Verification",
                        onPressed: () => cubit.verifyEmail(context),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
