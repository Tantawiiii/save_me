// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:shared_preferences/shared_preferences.dart';

import '../../home/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkAccessToken();
  }

  Future<void> checkAccessToken() async {
    // Get SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('access_token') ?? '';

    // Check if the access token is empty or not
    Widget nextScreen =
        accessToken.isNotEmpty ? const HomeScreen() : const LoginScreen();

    // Navigate to the next screen with a smooth transition
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

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
