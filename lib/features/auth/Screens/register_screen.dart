
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants/colors_code.dart';

import 'package:auto_route/auto_route.dart';

import '../widget/register_form.dart';


@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:  ColorScheme(
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
          elevation:12,
          shadowColor: Colors.black45,
          title: Image.asset(
            'assets/images/logo_save_me.png',
            fit: BoxFit.cover,
            height: 16,
            width: 100,
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          //iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: const RegisterForm(),
      ),
    );
  }
}
