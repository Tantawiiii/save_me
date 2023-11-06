import 'package:flutter/material.dart';
import 'package:save_me/constants/colors.dart';



  ThemeData appThemeLight = ThemeData(
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
        color: ColorsCode.whiteColor
    ),
    primaryColor: ColorsCode.whiteColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )
        ),
        backgroundColor: MaterialStateProperty.all<Color>(ColorsCode.blackColor),

      )
    )
  );



