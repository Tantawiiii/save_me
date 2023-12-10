import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/constants/colors_code.dart';
import '../../utils/constants/constants.dart';


class ThemeClass {
  Color lightPrimaryColor = ColorsCode.whiteColor;
  Color darkPrimaryColor = HexColor('#1f9b71');

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: _themeClass.lightPrimaryColor),
    // - - - - -Light Theme Elevated Button Styles - - - - -
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(double.infinity, 55),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => _themeClass.lightPrimaryColor),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
              (_) {
            return  RoundedRectangleBorder(borderRadius: kBorderRadius);
          },
        ),
        textStyle: MaterialStateProperty.resolveWith(
              (states) =>
          const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
        ),
        foregroundColor:
        MaterialStateProperty.all<Color>(Colors.white), //actual text color
      ),
    ),
  );
}
   ThemeClass _themeClass = ThemeClass();