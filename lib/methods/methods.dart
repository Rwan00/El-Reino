import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/consts.dart';
import '../models/message_model.dart';
import '../theme/fonts.dart';

void animatedNavigateTo(
    {required BuildContext context,
    required Widget widget,
    required PageTransitionType direction,
    required Curve curve}) {
  Navigator.push(
      context,
      PageTransition(
        child: widget,
        type: direction,
        curve: curve,
        //alignment: Alignment.bottomLeft,
        duration: const Duration(milliseconds: 700),
      ));
}

SnackBar buildSnackBar(
    {required BuildContext context, required String text, required Color clr}) {
  final snackBar = SnackBar(
    //padding: const EdgeInsets.all(0.0),
    //margin: const EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
    elevation: 0,
    backgroundColor: clr,
    content: Text(
      text,
      style: subTitle.copyWith(color: Colors.white),
    ),
    action: SnackBarAction(
      label: '',
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  return snackBar;
}

void animatedNavigateAndDelete(
    {required BuildContext context,
    required Widget widget,
    required PageTransitionType direction,
    required Curve curve}) {
  Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: widget,
        type: direction,
        curve: curve,
        //alignment: Alignment.bottomLeft,
        duration: const Duration(milliseconds: 700),
      ),
      (Route<dynamic> route) => false);
}

 void sendMessage({
    required String recieverId,
    required String dateTime,
    required String message,
  }) async {
    MessageModel messageModel = MessageModel(
      senderId: uId!,
      receiverId: recieverId,
      dateTime: dateTime,
      message: message,
    );
    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(uId)
          .collection("chats")
          .doc(recieverId)
          .collection("messages")
          .add(messageModel.toMap());
    } on FirebaseException catch (error) {
      print(error.message);
    }

    try {
      FirebaseFirestore.instance
          .collection("users")
          .doc(recieverId)
          .collection("chats")
          .doc(uId)
          .collection("messages")
          .add(messageModel.toMap());
    } on FirebaseException catch (error) {
      print(error.message);
    }
  }