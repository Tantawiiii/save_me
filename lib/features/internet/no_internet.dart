import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:save_me/constants/fonts.dart';

import '../../constants/Strings.dart';

class NoInternet extends StatelessWidget {

  final VoidCallback onRefresh;

  const NoInternet({super.key, required this.onRefresh});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(
          top: 100,
          right: 32,
          left: 32,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Lottie.asset('assets/anim/no_connection.json',
                animate: true,
                height: 300,
                width: 300),
            const SizedBox(height: 32,),
             Text(
                 Strings.txtOffline,
               style: TextStyle(
                 fontSize: 32,
                 fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                 color: Colors.black
               ),
             ),
            const SizedBox(height: 32,),
            Text(
              Strings.txtPleaseCheck,
               style: TextStyle(
                 fontSize: 14,
                 fontFamily: Fonts.getFontFamilyTitillRegular(),
                 color: Colors.black,
               ),
              textAlign: TextAlign.center,
             ),
            const SizedBox(height: 60,),
            SizedBox(
              width: 200,
              height: 56,
              child: ClipRRect(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: onRefresh,
                  child: Text(
                    Strings.txtBtnRef,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
