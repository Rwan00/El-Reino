class PostModel {
  String? name;
  String? uId;
  String? image;
  String? profileImage;
  String? dateTime;
  String? text;
  bool? isEmailVerified;
  int? likes;

  PostModel({
    required this.name,
    required this.uId,
    required this.dateTime,
    required this.text,
    required this.profileImage,
    required this.isEmailVerified,
    required this.likes,
    this.image,
  });
  factory PostModel.fromJson(json) {
    return PostModel(
      name: json?["name"],
      text: json?["text"],
      dateTime: json?["dateTime"],
      profileImage: json?["profileImage"],
      isEmailVerified: json?["isEmailVerified"],
      uId: json?["uId"],
      image: json?["image"],
      likes: json?["likes"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "dateTime": dateTime,
      "text": text,
      "uId": uId,
      "image": image,
      "profileImage": profileImage,
      "isEmailVerified": isEmailVerified,
      "likes":likes,
    };
  }
}
