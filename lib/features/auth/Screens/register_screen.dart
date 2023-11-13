import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widget/register_form.dart';

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
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.black12,
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
