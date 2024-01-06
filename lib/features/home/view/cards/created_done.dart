import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../utils/constants/colors_code.dart';
import '../../../../utils/constants/fonts.dart';
import '../../../../utils/strings/Language.dart';

class CreatedProfile extends StatelessWidget {
  const CreatedProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsCode.whiteColor,
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 80, right: 28, left: 28),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  Lottie.asset(
                    'assets/anim/create_done.json',
                    animate: true,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 44),
                  Text(
                    Language.instance.txtCreatedDone(),
                    textAlign: TextAlign.center,
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            Language.instance.txtCreatedNewBtn(),
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
                          Navigator.pushReplacementNamed(context, "/home");
                        },
                        child: Text(
                          Language.instance.txtBackToHomeBtn(),
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
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
