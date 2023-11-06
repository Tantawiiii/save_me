
// ignore_for_file: depend_on_referenced_packages

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;

import 'login_screen.dart';

class SplashScreen  extends StatelessWidget {
  const SplashScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 350,
        duration: 1000,
      animationDuration: const Duration(seconds: 1),
      backgroundColor: Colors.white,
        pageTransitionType: PageTransitionType.topToBottom,
        splashTransition: SplashTransition.rotationTransition,
        splash: const CircleAvatar(
          radius: 110,
          backgroundImage: AssetImage("assets/images/logowithnobg.png"),
          backgroundColor: Colors.white,
        ),
        nextScreen: const LoginScreen(),
    );
  }
}

