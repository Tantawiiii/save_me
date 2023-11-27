import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: Text(
          Strings.txtStartAddProfile,
          style: TextStyle(
            fontSize: 24,
            fontFamily: Fonts.getFontFamilyTitillBold(),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
