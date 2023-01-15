import 'package:flutter/material.dart';
import 'package:lancode/util/constants.dart';
import 'package:lancode/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreenHAnimated extends StatelessWidget {
  const SplashScreenHAnimated({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/json files/lancode.json"),
      splashIconSize: 450,
      backgroundColor: Colors.white,
      nextScreen: homePage(),
      pageTransitionType: PageTransitionType.bottomToTop,
    );
  }
}