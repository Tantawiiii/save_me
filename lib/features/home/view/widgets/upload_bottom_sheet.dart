import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:save_me/constants/fonts.dart';

import '../../../../constants/strings/utils/Language.dart';

void showBottomSheetDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    builder: (BuildContext context) {
      return SizedBox(
        height: 240,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 16,
            ),
            Lottie.asset(
              'assets/anim/done_anim.json',
              animate: true,
              height: 160,
              width: 160,
            ),
            //const SizedBox(height:16,),
            Text(
              Language.instance.txtBottomDialog(),
              style: TextStyle(
                fontSize:20,
                fontFamily: Fonts.getFontFamilyTitillSemiBold(),
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(() {
    // The bottom sheet is closed
    if (kDebugMode) {
      print('Bottom sheet closed');
    }
  });
  // Close the bottom sheet automatically
  Future.delayed(const Duration(milliseconds: 4000), () {
    Navigator.pop(context); // Close the bottom sheet
  });
}
