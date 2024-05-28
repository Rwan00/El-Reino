

abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {}

class GetAllUsersLoadingState extends AppStates {}

class GetAllUsersSuccessState extends AppStates {}

class GetAllUsersErrorState extends AppStates {}

class GetPostLoadingState extends AppStates {}

class GetPostSuccessState extends AppStates {}

class GetPostErrorState extends AppStates {}

class ReadMoreState extends AppStates {}

class AddCoverImageLoading extends AppStates {}

class AddCoverImageSuccess extends AppStates {}

class AddProfileImageLoading extends AppStates {}

class AddProfileImageSuccess extends AppStates {}

class AddPostImageLoading extends AppStates {}

class AddPostImageSuccess extends AppStates {}

class UploadPostImageError extends AppStates {}

class UploadPostImageSuccess extends AppStates {}

class AddMessageImageLoading extends AppStates {}

class AddMessageImageSuccess extends AppStates {}

class UploadMessageImageError extends AppStates {}

class UploadMessageImageSuccess extends AppStates {}

class UploadProfileImageError extends AppStates {}

class UploadProfileImageSuccess extends AppStates {}

class UploadCoverImageError extends AppStates {}

class UploadCoverImageSuccess extends AppStates {}

class UpdateUserLoadingState extends AppStates {}

class UpdateUserSuccessState extends AppStates {}

class UserUpdateError extends AppStates {
  final String error;
  UserUpdateError(this.error);
}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostErrorState extends AppStates {
  final String error;
  CreatePostErrorState(this.error);
}

class AddCommentSuccessState extends AppStates {}

class AddCommentErrorState extends AppStates {
  final String error;
  AddCommentErrorState(this.error);
}

class RemovePostImgState extends AppStates {}

class RemoveMessageImgState extends AppStates {}

class LikePostSuccessState extends AppStates {}

class SendMessageSuccess extends AppStates {}

class SendMessageError extends AppStates {}

class GetMessagesLoading extends AppStates {}

class GetMessageSuccess extends AppStates {}



class ChangeTabBar extends AppStates {}

class SavePostError extends AppStates {}






class AppChangeModeState extends AppStates {
 
}
