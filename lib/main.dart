import 'package:flutter/material.dart';
import 'package:save_me/src/features/authentuication/Screens/login_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo/logo_save_me.png',
              fit: BoxFit.cover,height: 35,width: 305,),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),

        body: const LoginScreen() ,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
