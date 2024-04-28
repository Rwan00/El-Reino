// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommentModel {
  String name;
  String image;
  String comment;
  String time;
  CommentModel({
    required this.name,
    required this.image,
    required this.comment,
    required this.time,
  });
  factory CommentModel.fromJson(json) {
    return CommentModel(
      name: json["name"],
      image: json["image"],
      comment: json["comment"],
      time: json["time"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "image": image,
      "comment": comment,
      "time":time,
    };
  }
}
