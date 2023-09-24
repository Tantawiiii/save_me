
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Center(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
