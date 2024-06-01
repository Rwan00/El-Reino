import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class AppLoginCubit extends Cubit<AppLoginState> {
  AppLoginCubit() : super(AppLoginInitialState());

  static AppLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password})async {
    emit(AppLoginLoadingState());
    try{
      var value = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    //print(value.user!.email);
      emit(AppLoginSuccessState(user: value.user!));
    }on FirebaseAuthException catch(error){
      emit(AppLoginErrorState(error.message??"Authintication Failed!"));

    }
  }

  Widget icon = const Icon(Icons.remove_red_eye_outlined);
  bool showPwd = false;

  void changePasswordVisibility() {
    showPwd = !showPwd;
    icon = showPwd
        ? const Icon(Icons.visibility_off_outlined)
        : const Icon(Icons.visibility_outlined);
    emit(AppChangePasswordVisibility());
  }
}
