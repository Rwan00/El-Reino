import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/user_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  late UserData userData;

  void getUserData() async {
    emit(GetUserLoadingState());

    try {
      var value =
          await FirebaseFirestore.instance.collection("users").doc(uId).get();
      print(value.data());
      userData = UserData.fromJson(value.data());
      emit(GetUserSuccessState());
    } on FirebaseException catch (error) {
      print(error.toString());
      emit(GetUserErrorState());
    }
  }

  bool flag = true;
  void readMore() {
    flag = !flag;
    emit(ReadMoreState());
  }
}
