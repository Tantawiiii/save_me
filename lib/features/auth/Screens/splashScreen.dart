// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

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

  String? accessToken;

  Future<void> checkAccessToken() async {
    // Get SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? '';

    print(accessToken);
    startTimer();
    // Check if the access token is empty or not
    // Widget nextScreen =
    //
    //
    // // Navigate to the next screen with a smooth transition
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => nextScreen),
    // );
    Countdown(
      seconds: 20,
      build: (BuildContext context, double time) => Text(time.toString()),
      interval: Duration(milliseconds: 100),
      onFinished: () {
        print('Timer is done!');
      },
    );
  }

  late Timer _timer;
  int _start = 3;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();

            accessToken != null && accessToken!.isNotEmpty
                ? const HomeScreen()
                : const LoginScreen();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
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
      nextScreen: accessToken != null && accessToken!.isNotEmpty
          ? const HomeScreen()
          : const LoginScreen(),
    );
  }
}
