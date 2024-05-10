import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_reino/widgets/loading_widget.dart';
import 'package:el_reino/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

import '../constants/consts.dart';
import '../models/user_model.dart';
import '../theme/fonts.dart';

class ChatMessages extends StatelessWidget {
  final UserData user;
  const ChatMessages({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(uId!)
            .collection("chats")
            .doc(user.uId)
            .collection("messages")
            .orderBy(
              "dateTime",
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Messages Found!",
                style: titleStyle,
              ),
            );
          } else if (snapshot.hasError) {
            return Text(
              "Something Went Wrong...",
              style: titleStyle,
            );
          } else {
            final messages = snapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                bottom: 40,
                left: 13,
                right: 13,
              ),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                final nextMessage =
                    index + 1 < messages.length ? messages[index + 1] : null;
                final currentMessageUserId = message["senderId"];
                final nextMessageUserId =
                    nextMessage != null ? message["senderId"] : null;

                final bool nextUserIsSame =
                    nextMessageUserId == currentMessageUserId;
                if (nextUserIsSame) {
                  return MessageBubble.next(
                      message: message["message"],
                      //file: chat.file,
                      //lat: chat.latitude,
                      // lng: chat.longitude,
                      time: message["dateTime"],
                      isMe: uId == message["senderId"]);
                } else {
                  return MessageBubble.first(
                    userImage: user.image,
                    username: user.name,
                    message: message["message"],
                    //lat: chat.latitude,
                    //lng: chat.longitude,
                    //file: chat.file,
                    time: message["dateTime"],
                    isMe: uId == currentMessageUserId,
                  );
                }
              },
            );
          }
        });
  }
}
