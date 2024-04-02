class UserData {
  String name;
  String email;
  String phone;
  String uId;
  UserData({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
  });
  factory UserData.fromJson(json) {
    return UserData(
      email: json["email"],
      name: json["name"],
      phone: json["phone"],
      uId: json["uId"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name":name,
      "email":email,
      "phone":phone,
      "uId":uId,
    };
  }
}
