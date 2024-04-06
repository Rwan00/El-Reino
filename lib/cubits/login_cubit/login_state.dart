

import 'package:firebase_auth/firebase_auth.dart';

abstract class AppLoginState {}

class AppLoginInitialState extends AppLoginState {}

class AppLoginLoadingState extends AppLoginState {}

class AppLoginSuccessState extends AppLoginState {
  final User user;
  AppLoginSuccessState({required this.user});
}

class AppLoginErrorState extends AppLoginState {
  final String error;
  AppLoginErrorState(this.error);
}

class AppChangePasswordVisibility extends AppLoginState {}
