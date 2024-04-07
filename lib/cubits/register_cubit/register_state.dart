abstract class AppRegisterState {}

class AppRegisterInitialState extends AppRegisterState {}

class AppRegisterLoadingState extends AppRegisterState {}

class AppRegisterSuccessState extends AppRegisterState {
  /* final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel); */
}

class AppRegisterErrorState extends AppRegisterState {
  final String error;

  AppRegisterErrorState({required this.error});
}

class AppCreateUserLoadingState extends AppRegisterState {}

class AppCreateUserSuccessState extends AppRegisterState {
  /* final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel); */
}

class AppCreateUserErrorState extends AppRegisterState {
  final String error;
  AppCreateUserErrorState(this.error);
}

class AppChangePasswordVisibility extends AppRegisterState {}

class AppUpdateWidgets extends AppRegisterState {}

class VerifyEmailLoadingState extends AppRegisterState {}

class VerifyEmailSuccessState extends AppRegisterState {}

class VerifyEmailErrorState extends AppRegisterState {
  final String error;
  VerifyEmailErrorState(this.error);
}
class UpdateVerifyEmailLoadingState extends AppRegisterState {}

class UpdateVerifyEmailSuccessState extends AppRegisterState {}

class UpdateVerifyEmailErrorState extends AppRegisterState {
  final String error;
  UpdateVerifyEmailErrorState(this.error);
}

class AddImageLoading extends AppRegisterState {}

class AddImageSuccess extends AppRegisterState {}
