import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/models/user_model.dart';
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
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
     
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
    UserData userData = UserData(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
    );
    emit(AppCreateUserLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(userData.toMap())
        .then((value) {
      emit(AppCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppCreateUserErrorState());
    });
  }
}
