class UserData {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;


  UserData({
     required this.email,
     required this.name,
     required this.phone,
     required this.uId,
     required this.image,
     required this.cover,
     required this.bio,
     required this.isEmailVerified,
  });
  factory UserData.fromJson(json) {
    return UserData(
      email: json?["email"],
      name: json?["name"],
      phone: json?["phone"],
      uId: json?["uId"],
      image: json?["image"],
      cover: json?["cover"],
      bio: json?["bio"],
      isEmailVerified: json?["isEmailVerified"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "image": image,
      "cover": cover,
      "bio": bio,
      "isEmailVerified":isEmailVerified,
    };
  }
}
