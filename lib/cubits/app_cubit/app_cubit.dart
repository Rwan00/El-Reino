import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/models/post_model.dart';
import 'package:el_reino/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
    } on FirebaseException catch (error) {
      print(error.message);
      emit(UploadPostImageError());
    }
  }

  void createNewPost({
    required String text,
  }) async {
    PostModel model = PostModel(
      name: userData!.name,
      isEmailVerified: userData!.isEmailVerified,
      uId: uId,
      image: postImgUrl,
      dateTime:
          DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(DateTime.now()),
      text: text,
      profileImage: userData!.image,
      likes: 0,
      likesList: [],
    );

    try {
      emit(CreatePostLoadingState());

      await FirebaseFirestore.instance.collection("posts").add(model.toMap());

      emit(CreatePostSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(CreatePostErrorState(error.message!));
    }
  }

  void removePostImg() {
    pickedPostImage = null;
    emit(RemovePostImgState());
  }

  void addComment(postId){
    
  }

  /*  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<bool> likeStatusList = []; */

  /* void getPosts() async {
    emit(GetPostLoadingState());
    try {
      var postsValue =
          await FirebaseFirestore.instance.collection("posts").get();

      //print(value.docs);
      for (var post in postsValue.docs) {
        /*  print(post.data()["likedBy"]);
        //usersLikes.add(likesData.data()?["like"]);
        //print(likesValue.docs.length);
        //print(likesValue.docs.first);
        //likes.add(likesValue.docs.length);
        likedBy.addAll(post.data()["likedBy"]); */

        postsId.add(post.id);
        likeStatusList.add(false);

        posts.add(PostModel.fromJson(post.data()));
      }

      await Future.forEach(postsId, (postId) async {
        DocumentSnapshot postDoc = await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .get();
        Map<String, dynamic>? postData =
            postDoc.data() as Map<String, dynamic>?;

        Map<String, dynamic>? likedBy = postData?['likedBy'];
        if (likedBy != null && likedBy.containsKey(uId)) {
          likeStatusList[postsId.indexOf(postId)] = true;
        }
      });

      emit(PostLikesLoadedState(likeStatusList));

      emit(GetPostSuccessState());
    } on FirebaseException catch (error) {
      print(error.message);
      emit(GetPostErrorState());
    }
  } */
  

 

 

  /* void toggleLike(int index) async {
    String postId = postsId[index];

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('posts').doc(postId);

    if (!likeStatusList[index]) {
      postRef.update({
        'likes': FieldValue.increment(1),
        'likedBy.$uId': true,
      });
    } else {
      postRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy.$uId': FieldValue.delete(),
      });
    }

    likeStatusList[index] = !likeStatusList[index];
   
    
    emit(PostLikesLoadedState(likeStatusList));
  } */
}

  // bool isLiked = false;
  // late int likesCount;

  // void likePost(String postId) async {
  //   try {
  //     // Get reference to the Firestore document
  //   DocumentReference postRef =
  //       FirebaseFirestore.instance.collection('posts').doc(postId);

  //   if (!isLiked) {
  //     // If post is not liked, add user ID to the list of likes
  //     postRef.update({
  //       'likes': FieldValue.increment(1),
  //       'likedBy.$uId': true,
  //     });

  //       likesCount++;
  //       isLiked = true;

  //   } else {
  //     // If post is already liked, remove user ID from the list of likes
  //     postRef.update({
  //       'likes': FieldValue.increment(-1),
  //       'likedBy.$uId': FieldValue.delete(),
  //     });

  //       likesCount--;
  //       isLiked = false;

  //   }

  //     emit(LikePostSuccessState());
  //   } on FirebaseException catch (error) {
  //     isLiked = false;
  //     print(error.message);
  //     emit(LikePostErrorState());
  //   }
  // }

