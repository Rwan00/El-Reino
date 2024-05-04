class MessageModel {
  String senderId;
  String receiverId;
  String dateTime;
  String message;
  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.message,
  });
  factory MessageModel.fromJson(json) {
    return MessageModel(
      senderId: json["senderId"],
      receiverId: json["receiverId"],
      dateTime: json["dateTime"],
      message: json["message"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "dateTime": dateTime,
      "message":message,
    };
  }
}
