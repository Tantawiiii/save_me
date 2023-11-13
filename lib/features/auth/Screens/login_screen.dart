import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          elevation: 5,
          shadowColor: Colors.black12,
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
          backgroundColor: Colors.white,

        ),
        body: const Center(
            child: LoginForm(),
        ),
      ),
    );
  }
}
