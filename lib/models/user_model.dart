class UserData {
  String name;
  String email;
  String phone;
  String uId;
  bool isEmailVerified;

  UserData({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    required this.isEmailVerified,
  });
  factory UserData.fromJson(json) {
    return UserData(
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      uId: json["uId"],
      isEmailVerified: json["isEmailVerified"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "uId": uId,
      "isEmailVerified":isEmailVerified,
    };
  }
}
