// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart' show PageTransitionType;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../home/home_screen.dart';
import '../../internet/no_internet.dart';
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
    checkConnectivity();
  }

  void checkConnectivity() async {
    await Connectivity().checkConnectivity();
  }

  String? accessToken;

  Future<void> checkAccessToken() async {
    // Get SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? '';

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
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        if (kDebugMode) {
          print('Timer is done!');
        }
      },
    );
  }

  late Timer _timer;
  int _start = 3;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() async {
            timer.cancel();

            // accessToken != null && accessToken!.isNotEmpty
            //     ? const HomeScreen()
            //     : const LoginScreen();
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
      nextScreen: StreamBuilder<ConnectivityResult>(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, connectivitySnapshot) {
            if (connectivitySnapshot.data == ConnectivityResult.none) {
              return const NoInternet();
            } else {
              return accessToken != null && accessToken!.isNotEmpty
                  ? const HomeScreen()
                  : const LoginScreen();
            }
          }),
    );
  }
}
