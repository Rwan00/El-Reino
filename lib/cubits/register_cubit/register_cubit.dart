import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class AppRegisterCubit extends Cubit<AppRegisterState> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(AppRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(AppRegisterSuccessState());
    }).catchError((error) {
      print(error);
      emit(AppRegisterErrorState());
    });
  }
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    emit(AppCreateUserLoadingState());
   
  }
}
