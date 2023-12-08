import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:save_me/constants/fonts.dart';

import '../../../../constants/strings/utils/Language.dart';
import '../../provider/speed_dial_provider.dart';
import 'package:auto_route/auto_route.dart';


@RoutePage()
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:  Center(
        child: GestureDetector(
          onTap: (){
            Provider.of<SpeedDialProvider>(context, listen: false).toggleDial();
          },
          child: Text(
            Language.instance.txtStartAddProfile(),
            style: TextStyle(
              fontSize: 24,
              fontFamily: Fonts.getFontFamilyTitillBold(),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
