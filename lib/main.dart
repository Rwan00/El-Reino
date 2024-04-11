import 'package:el_reino/cubits/app_cubit/app_cubit.dart';
import 'package:el_reino/cubits/app_cubit/app_state.dart';
import 'package:el_reino/cubits/register_cubit/register_cubit.dart';
import 'package:el_reino/helper/cache_helper.dart';
import 'package:el_reino/screens/app_layout.dart';
import 'package:el_reino/screens/login_screen.dart';
import 'package:el_reino/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/consts.dart';
import 'cubits/bloc_observer.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          create: (context) => AppCubit()..getUserData()..getPosts(),
        ),
        BlocProvider(
          create: (context) => AppRegisterCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(0, 141, 218, 1),
              ),
              useMaterial3: false,
            ),
            home: SplashScreen(
              startWidget: startWidget,
            ),
          );
        },
      ),
    );
  }
}
