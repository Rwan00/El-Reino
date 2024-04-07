import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/consts.dart';

import 'register_state.dart';

class AppRegisterCubit extends Cubit<AppRegisterState> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(AppRegisterLoadingState());

    try {
      var value = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    } on FirebaseAuthException catch (error) {
      print(error);
      emit(AppRegisterErrorState(
          error: error.message ?? "Authintication Failed!"));
    }
  }

  late UserData userData;
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) async {
    userData = UserData(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      isEmailVerified: false,
    );
    emit(AppCreateUserLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .set(userData.toMap());
      emit(AppCreateUserSuccessState());
    } on FirebaseException catch (error) {
      print(error.toString());
      emit(AppCreateUserErrorState(error.message ?? "Authintication Failed!"));
    }
  }

  void verifyEmail(context) async {
    emit(VerifyEmailLoadingState());
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      emit(VerifyEmailSuccessState());
      updatVerification();
    } on FirebaseException catch (error) {
      print(error.toString());
      emit(VerifyEmailErrorState(error.message ?? "Authintication Failed!"));
    }
  }

  void updatVerification() async {
    emit(UpdateVerifyEmailLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .update({"isEmailVerified": true});
      emit(UpdateVerifyEmailSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UpdateVerifyEmailErrorState(
          error.message ?? "Authintication Failed!"));
    }
  }
}
