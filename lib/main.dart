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
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/consts.dart';
import 'cubits/bloc_observer.dart';
import 'cubits/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';

Future<void> firebaseMassegingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
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
    print(event.data.toString());
    print("On Message");
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
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
  bool? isDark = CacheHelper.getData(key: "isDark");

  runApp(MyApp(
    startWidget: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? isDark;
  const MyApp({required this.startWidget, required this.isDark, super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getUserData()
            ..getAllUsers()
            ..changeAppMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => AppRegisterCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print("themeMode ${AppCubit.get(context).isDark}");
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(0, 141, 218, 1),
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: const Color.fromARGB(255, 101, 100, 100),
              appBarTheme: const AppBarTheme(
                  titleSpacing: 20,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light),
                  backgroundColor: Colors.black,
                  elevation: 0,
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  iconTheme: IconThemeData(color: Colors.white)),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Color.fromARGB(255, 101, 100, 100),
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.orangeAccent,
                  elevation: 20),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  primary: Colors.deepOrangeAccent),
              textTheme: const TextTheme(
                bodyLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                bodySmall: TextStyle(color: Colors.white, fontSize: 15),
              ),
              //useMaterial3: true,
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: SplashScreen(
              startWidget: startWidget,
            ),
          );
        },
      ),
    );
  }
}
