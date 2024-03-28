abstract class AppLoginState {}

class AppLoginInitialState extends AppLoginState {}

class AppLoginLoadingState extends AppLoginState {}

class AppLoginSuccessState extends AppLoginState {}

class AppLoginErrorState extends AppLoginState {
  final String error;
 AppLoginErrorState(this.error);
}

class AppChangePasswordVisibility extends AppLoginState{}

