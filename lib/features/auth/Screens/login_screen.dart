import 'package:flutter/material.dart';
import '../widget/login_form.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo_save_me.png',
            fit: BoxFit.cover,
            height: 16,
            width: 100,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 4,
        ),
        body: Center(
            child: LoginForm(),
        ),
      ),
    );
  }
}
