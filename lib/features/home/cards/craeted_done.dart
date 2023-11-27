import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:save_me/constants/Strings.dart';
import 'package:save_me/constants/colors_code.dart';
import 'package:save_me/constants/fonts.dart';
import 'package:save_me/features/home/cards/add_kid_profile.dart';
import 'package:save_me/features/home/home_screen.dart';

class CreatedProfile extends StatelessWidget {
  const CreatedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCode.whiteColor,
      body: Container(
        margin: const EdgeInsets.only(top: 80, right: 28, left: 28),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Lottie.asset('assets/anim/create_done.json',
                  animate: true,
                  height: 200,
                  width: 200,
              ),
              const SizedBox(height: 44),
              Text(
                Strings.txtCreatedDone,
                style: TextStyle(
                  color: ColorsCode.blueDarkColor,
                  fontSize: 18,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 56,
                    //width: 155,
                    child: ElevatedButton(
                      onPressed: () => {
                        HomePage.homePageKey.currentState?.openSpeedDial()
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        Strings.txtCreatedNewBtn,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    child: Text(
                      Strings.txtBackToHomeBtn,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                          color: ColorsCode.blueDarkColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
