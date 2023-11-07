import 'package:flutter/material.dart';
import 'package:save_me/constants/colors_code.dart';


  ThemeData appThemeLight = ThemeData(
      primaryColor: ColorsCode.whiteColor,
    appBarTheme: AppBarTheme(
            backgroundColor: ColorsCode.whiteColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24.0,
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          )
        ),
        backgroundColor: MaterialStateProperty.all<Color>(ColorsCode.blackColor),

      )
    ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white)
  );



