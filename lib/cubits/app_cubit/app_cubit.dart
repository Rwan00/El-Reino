import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/comment_model.dart';

import 'package:el_reino/models/post_model.dart';
import 'package:el_reino/models/user_model.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../helper/cache_helper.dart';
import '../../models/message_model.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  final key = "isDarkMode";

  saveThemeToBox(bool isDark) => CacheHelper.saveData(key: key, value: isDark);

  bool loadThemeFromBox() => CacheHelper.getData(key: key) ?? false;

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
    emit(AppChangeModeState());
  }

  UserData? userData;

  void getUserData() async {
    emit(GetUserLoadingState());

    try {
      var value =
          await FirebaseFirestore.instance.collection("users").doc(uId).get();

      userData = UserData.fromJson(value.data());
      print("cubit user: ${userData!.name}");
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
      emit(UploadProfileImageSuccess());
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
      emit(UploadCoverImageSuccess());
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
      uId: uId!,
      isEmailVerified: userData!.isEmailVerified,
      followers: userData!.followers,
      followings: userData!.followings,
      posts: userData!.posts,
      savedPosts: userData!.savedPosts,
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

  File? pickedPostImage;

  fetchPostImage() async {
    emit(AddPostImageLoading());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    pickedPostImage = File(image.path);
    uploadPostImage();
    emit(AddPostImageSuccess());
  }

  String? postImgUrl;
  void uploadPostImage() async {
    Reference? storageRef;
    try {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("posts_images")
          .child(Uri.file(pickedPostImage!.path).pathSegments.last);
      await storageRef.putFile(pickedPostImage!);
      emit(UploadPostImageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadPostImageError());
    }
    try {
      postImgUrl = await storageRef!.getDownloadURL();
      log(postImgUrl!);
      emit(UploadPostImageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadPostImageError());
    }
  }

  void createNewPost({
    required String text,
  }) async {
    print("method:${userData!.name}");
    PostModel model = PostModel(
      name: userData!.name,
      isEmailVerified: userData!.isEmailVerified,
      uId: uId,
      image: postImgUrl,
      dateTime:
          DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(DateTime.now()),
      text: text,
      profileImage: userData!.image,
      likes: [],
    );

    try {
      emit(CreatePostLoadingState());

      var value = await FirebaseFirestore.instance
          .collection("posts")
          .add(model.toMap());

      DocumentReference meRef =
          FirebaseFirestore.instance.collection("users").doc(uId);

      meRef.update({
        "posts": FieldValue.arrayUnion([value.id])
      });

      // callOnFcmApiSendPushNotifications(
      //   title: "New Post",
      //   body: "see ${userData!.name}'s new post",
      // );

      emit(CreatePostSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(CreatePostErrorState(error.message!));
    }
  }

  void removePostImg() {
    pickedPostImage = null;
    postImgUrl = null;
    emit(RemovePostImgState());
  }

  void addComment({
    required postId,
    required commentText,
  }) async {
    CommentModel comment = CommentModel(
      name: userData!.name,
      image: userData!.image,
      comment: commentText,
      time: DateTime.now().toString(),
    );
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .collection("Comments")
          .add(comment.toMap());

      emit(AddCommentSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(AddCommentErrorState(error.message!));
    }
  }

  List<UserData> users = [];

  void getAllUsers() async {
    emit(GetAllUsersLoadingState());

    try {
      var value = await FirebaseFirestore.instance.collection("users").get();
      for (var u in value.docs) {
        users.add(UserData.fromJson(u.data()));
      }
      //print("users: $users");
      emit(GetAllUsersSuccessState());
    } on FirebaseException catch (error) {
      print(error.toString());
      emit(GetAllUsersErrorState());
    }
  }

  File? pickedImage;

  fetchImage() async {
    emit(AddMessageImageLoading());
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    pickedImage = File(image.path);
    uploadImage();
    emit(AddMessageImageSuccess());
  }

  String? imgUrl;
  void uploadImage() async {
    Reference? storageRef;
    try {
      storageRef = FirebaseStorage.instance
          .ref()
          .child("messages_images")
          .child(Uri.file(pickedImage!.path).pathSegments.last);
      await storageRef.putFile(pickedImage!);
      emit(UploadMessageImageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadMessageImageError());
    }
    try {
      imgUrl = await storageRef!.getDownloadURL();
      log(imgUrl!);
      emit(UploadMessageImageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadMessageImageError());
    }
  }

  void sendMessage({
    required String recieverId,
    required String dateTime,
    required String message,
  }) async {
    MessageModel messageModel = MessageModel(
      senderId: uId!,
      receiverId: recieverId,
      dateTime: dateTime,
      message: message,
      imgUrl: imgUrl,
    );
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .collection("chats")
          .doc(recieverId)
          .collection("messages")
          .add(messageModel.toMap());
      emit(SendMessageSuccess());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(SendMessageError());
    }

    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(recieverId)
          .collection("chats")
          .doc(uId)
          .collection("messages")
          .add(messageModel.toMap());
    } on FirebaseException catch (error) {
      print(error.message);
    }

    pickedImage = null;
    imgUrl = null;
  }

  void removeMessageImg() {
    pickedImage = null;
    imgUrl = null;
    emit(RemoveMessageImgState());
  }

  int currentIndex = 0;
  void changeTabBar(int index) {
    currentIndex = index;
    //print(currentIndex);
    emit(ChangeTabBar());
  }

  
}
