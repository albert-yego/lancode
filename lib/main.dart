import 'package:lancode/login/login.dart';
import 'package:lancode/login/splash/animated_splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lancode',
      debugShowCheckedModeBanner: false,
      home: SplashScreenLAnimated(),
    );
  }
}