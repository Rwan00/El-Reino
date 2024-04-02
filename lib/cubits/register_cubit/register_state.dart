abstract class AppRegisterState {}

class AppRegisterInitialState extends AppRegisterState {}

class AppRegisterLoadingState extends AppRegisterState {}

class AppRegisterSuccessState extends AppRegisterState {
  /* final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel); */
}

class AppRegisterErrorState extends AppRegisterState {}

class AppCreateUserLoadingState extends AppRegisterState {}

class AppCreateUserSuccessState extends AppRegisterState {
  /* final ShopLoginModel loginModel;
  ShopRegisterSuccessState(this.loginModel); */
}

class AppCreateUserErrorState extends AppRegisterState {}

class AppChangePasswordVisibility extends AppRegisterState{}
class AppUpdateWidgets extends AppRegisterState{}
