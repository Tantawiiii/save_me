import 'package:flutter/material.dart';
import 'package:save_me/src/features/authentication/widget/register_form.dart';

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
          title: Image.asset(
            'assets/images/logo_save_me.png',
            fit: BoxFit.cover,
            height: 18,
            width: 120,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 8,
        ),
        body: const RegisterForm(),
      ),
    );
  }
}
