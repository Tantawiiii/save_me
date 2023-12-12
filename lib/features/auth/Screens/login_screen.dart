import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants/colors_code.dart';
import '../widget/login_form.dart';

import 'package:auto_route/auto_route.dart';


@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {




  //internet Connection
  // bool isOnline = true;
  // @override
  // void initState() {
  //   super.initState();
  //   // Listen to internet status changes
  //   internetStatusController.stream.listen((bool online) {
  //     setState(() {
  //       isOnline = online;
  //     });
  //   });
  //
  //   // Initialize the UI with the current internet status
  //   checkInternetStatus();
  // }
  // void _onStatusChange(bool online) {
  //   setState(() {
  //     isOnline = online;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: ColorsCode.whiteColor,
          onPrimary: ColorsCode.blackColor,
          secondary: Colors.white,
          onSecondary: Colors.grey,
          background: Colors.white,
          onBackground: Colors.grey,
          error: Colors.red,
          onError: ColorsCode.grayColor,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 12,
          shadowColor: Colors.black45,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: Image.asset(
            'assets/images/logo_save_me.png',
            fit: BoxFit.cover,
            height: 16,
            width: 100,
          ),
          centerTitle: true,
          backgroundColor: ColorsCode.whiteColor,
        ),
        body: const Center(
          child:LoginForm() ,
        ),
      ),
    );
  }
}


/**
 * isOnline
    ? const LoginForm()
    : NoInternet(
    onRefresh: () {
    refreshInternetStatus();
    },
    ),
 */
