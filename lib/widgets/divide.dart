import 'package:el_reino/constants/consts.dart';
import 'package:flutter/material.dart';




class Divide extends StatelessWidget {
  const Divide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 1,
        width: 390,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: [
                primaryBlue,
                lightBlue,
                primaryLightTeal,

              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.mirror,),
        ),
      ),
    );
  }
}