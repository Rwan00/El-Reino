import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/user_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

   UserData? userData;

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

   final ImagePicker coverPicker = ImagePicker();
  File? pickedCoverImage;
  

  fetchCoverImage() async {
    emit(AddCoverImageLoading());
    final XFile? image = await coverPicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    pickedCoverImage = File(image.path);
    emit(AddCoverImageSuccess());
  }

  bool flag = true;
  void readMore() {
    flag = !flag;
    emit(ReadMoreState());
  }
}
