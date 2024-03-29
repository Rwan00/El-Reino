import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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