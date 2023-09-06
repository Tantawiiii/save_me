
// Login Screen Code
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Image.asset('assets/images/logo/logo_save_me.png'), //   <-- image
      ),
      debugShowCheckedModeBanner: false,
    );
  }
  
}
