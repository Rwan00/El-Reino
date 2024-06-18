import 'package:el_reino/constants/consts.dart';
import 'package:el_reino/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:page_transition/page_transition.dart';

import '../helper/cache_helper.dart';
import '../screens/splash_screen.dart';
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

void signOut(context) async {
  var uIdValue = await CacheHelper.removeData(key: "uId");
  var themeValue = await CacheHelper.removeData(key: "isDarkMode");
  var tokenValue = await CacheHelper.removeData(key: "token");
  if (uIdValue! && themeValue! && tokenValue!) {
    //print(themeValue);
    animatedNavigateAndDelete(
      context: context,
      widget: const SplashScreen(
        startWidget: LoginScreen(),
      ),
      curve: Curves.easeInCirc,
      direction: PageTransitionType.fade,
    );
  }
}

void buildDialog(
    {required BuildContext context,
    required String title,
    required String message,
    required void Function() onPressed,
    required String btnTxt}) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  final AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    contentTextStyle: subTitle,
    title: Text(
      title,
      style: heading,
    ),
    content: SizedBox(
      height: height * 0.15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: onPressed,
                    child: Text(
                      btnTxt,
                      style: GoogleFonts.lato(color: Colors.white),
                    )),
              ),
              SizedBox(
                width: width * 0.045,
              ),
              Expanded(
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(primaryBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.lato(color: Colors.white),
                    )),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return alert;
    },
    barrierDismissible: false,
    //barrierColor: Colors.orange.withOpacity(0.3)
  );
}
