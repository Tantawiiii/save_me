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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Column(
          children: [
            Text(
              Strings.txtAppBarHome,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                fontSize: 16,
              ),
            ),
            Text(
              Strings.txtAppBarWelcome,
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                fontSize: 10,
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active) ,
            padding: const EdgeInsets.only(right: 12),
            onPressed: () {},
          ),
        ],
        elevation: 5,
        shadowColor: Colors.black12,
        leading:const Padding(
          padding: EdgeInsets.only(left: 4.0),
          child: Image(
            image: AssetImage('assets/images/logowithnobg.png'),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
