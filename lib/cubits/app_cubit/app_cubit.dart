import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/user_model.dart';

import 'package:firebase_storage/firebase_storage.dart';

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

  final ImagePicker picker = ImagePicker();

  File? pickedCoverImage;

  fetchCoverImage() async {
    emit(AddCoverImageLoading());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    pickedCoverImage = File(image.path);
    uploadCoverImage();
    emit(AddCoverImageSuccess());
  }

  File? pickedProfileImage;

  fetchProfileImage() async {
    emit(AddProfileImageLoading());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    pickedProfileImage = File(image.path);
    uploadProfileImage();
    emit(AddProfileImageSuccess());
  }

  bool flag = true;
  void readMore() {
    flag = !flag;
    emit(ReadMoreState());
  }

  String? profileImgUrl;
  void uploadProfileImage() async {
    Reference? storageRef;
    try {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("user_images")
          .child(Uri.file(pickedProfileImage!.path).pathSegments.last);
      await storageRef.putFile(pickedProfileImage!);
      emit(UploadProfileImageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadProfileImageError());
    }
    try {
      profileImgUrl = await storageRef!.getDownloadURL();
      log(profileImgUrl!);
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadProfileImageError());
    }
  }

  String? coverImgUrl;
  void uploadCoverImage() async {
    Reference? storageRef;
    try {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("user_images")
          .child(Uri.file(pickedCoverImage!.path).pathSegments.last);
      await storageRef.putFile(pickedCoverImage!);
      emit(UploadCoverImageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadCoverImageError());
    }
    try {
      coverImgUrl = await storageRef!.getDownloadURL();
      log(coverImgUrl!);
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadCoverImageError());
    }
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
   
  }) async {
    UserData model = UserData(
      name: name,
      phone: phone,
      image: profileImgUrl ?? userData!.image,
      cover: coverImgUrl ?? userData!.cover,
      bio: bio,
      email: userData!.email,
      uId: uId,
      isEmailVerified: userData!.isEmailVerified,
    );

    try {
      emit(UpdateUserLoadingState());
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .update(model.toMap());
      getUserData();
       
      emit(UpdateUserSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UserUpdateError(error.message!));
    }
  }
}
