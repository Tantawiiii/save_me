
// ignore_for_file: depend_on_referenced_packages

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;

import 'login_screen.dart';


import 'package:auto_route/auto_route.dart';
@RoutePage()
class SplashScreen  extends StatelessWidget {
  const SplashScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 400,
        duration: 1000,
      animationDuration: const Duration(milliseconds: 3000),
      backgroundColor: Colors.white,
        pageTransitionType: PageTransitionType.topToBottom,
        splashTransition: SplashTransition.fadeTransition,
        splash: const CircleAvatar(
          radius: 150,
          backgroundImage: AssetImage("assets/images/logowithnobg.png"),
          backgroundColor: Colors.white,
        ),
        nextScreen: const LoginScreen(),
    );
  }
}

