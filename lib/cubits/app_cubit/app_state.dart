abstract class AppStates {}

class AppInitialState extends AppStates {}

class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates {}

class ReadMoreState extends AppStates {}

class AddCoverImageLoading extends AppStates {}

class AddCoverImageSuccess extends AppStates {}

class AddProfileImageLoading extends AppStates {}

class AddProfileImageSuccess extends AppStates {}

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
