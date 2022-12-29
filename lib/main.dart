import 'package:lanquiz/login/home_page.dart';
import 'package:lanquiz/login/splash/animated_splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanquiz',
      debugShowCheckedModeBanner: false,
      home: SplashScreenHAnimated(),
    );
  }
}
