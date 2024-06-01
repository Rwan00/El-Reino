import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/cubits/register_cubit/register_cubit.dart';
import 'package:el_reino/helper/cache_helper.dart';

import 'package:el_reino/screens/app_layout.dart';
import 'package:el_reino/screens/login_screen.dart';
import 'package:el_reino/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'constants/consts.dart';
import 'cubits/bloc_observer.dart';

import 'firebase_options.dart';
import 'theme/theme_data.dart';

Future<void> firebaseMassegingBackgroundHandler(RemoteMessage message) async {
  //print(message.data.toString());
  print("On Background Message ");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = await FirebaseMessaging.instance.getToken();
  print("token: $token");

  FirebaseMessaging.onMessage.listen((event) {
    //print(event.data.toString());
    print("On Message");
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //print(event.data.toString());
    print("On Message Opened App");
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMassegingBackgroundHandler);
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: "uId");
  if (uId != null) {
    widget = const SocialAppLayout();
  } else {
    widget = const LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({required this.startWidget, super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            
            ..getAllUsers(),
        ),
        BlocProvider(
          create: (context) => AppRegisterCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print("user main: ${AppCubit.get(context).userData}");
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Themes.light,
            darkTheme: Themes.dark,
            themeMode: AppCubit.get(context).theme,
            home: SplashScreen(
              startWidget: startWidget,
            ),
          );
        },
      ),
    );
  }
}
