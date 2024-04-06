import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../constants/consts.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../cubits/login_cubit/login_state.dart';
import '../theme/fonts.dart';

class InputField extends StatelessWidget {
  final String? title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? textType;
  final bool isPassword;
  final Function(String)? onChanged;

  const InputField(
      { this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.textType,
      this.onChanged,
      this.isPassword = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider ( create: (context) => AppLoginCubit(),),
      
      
      ],
      child: BlocConsumer<AppLoginCubit, AppLoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppLoginCubit.get(context);
          bool showPwd = cubit.showPwd;
          return Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(title != null)
                  Text(
                    title!,
                    style: titleStyle,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      onChanged: onChanged,
                     
                      obscureText: isPassword && !showPwd,
                      controller: controller,
                      keyboardType: textType,
                      autofocus: false,
                      style: titleStyle,
                      cursorColor: primaryBlue,
                      decoration: InputDecoration(
                        suffixIcon: isPassword
                            ? IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                icon: cubit.icon,
                              )
                            : widget,
                        hintText: hint,
                        hintStyle: subTitle,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: primaryLightTeal,
                              width: 2,
                            )),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
