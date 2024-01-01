import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/fonts.dart';
import '../../utils/strings/Language.dart';

class NoInternet extends StatelessWidget {
  // final VoidCallback onRefresh;

  const NoInternet({
    super.key,
  });

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
              Language.instance.txtAppBarHome(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                fontSize: 16,
              ),
            ),
            Text(
              Language.instance.txtAppBarWelcome(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                fontSize: 10,
              ),
            ),
          ],
        ),
        toolbarHeight: 70,
        elevation: 12,
        shadowColor: Colors.black45,
        leading: const Padding(
          padding: EdgeInsets.only(left: 3.0),
          child: Image(
            image: AssetImage('assets/images/logowithnobg.png'),
          ),
        ),
        centerTitle: true,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
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
                animate: true, height: 300, width: 300),
            const SizedBox(
              height: 32,
            ),
            Text(
              Language.instance.txtOffline(),
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                  color: Colors.black),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              Language.instance.txtPleaseCheck(),
              style: TextStyle(
                fontSize: 14,
                fontFamily: Fonts.getFontFamilyTitillRegular(),
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60,
            ),
            // SizedBox(
            //   width: 200,
            //   height: 56,
            //   child: ClipRRect(
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.black,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: Text(
            //         Language.instance.txtBtnRef(),
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontFamily: Fonts.getFontFamilyTitillSemiBold(),
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
