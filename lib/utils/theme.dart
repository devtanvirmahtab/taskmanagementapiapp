import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lightTheme (BuildContext context) => ThemeData(
    scaffoldBackgroundColor: appPrimaryLightColor,
    appBarTheme: AppBarTheme(
        color: appPrimaryColor,
        titleTextStyle: TextStyle()
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: appPrimaryColor.withOpacity(.2),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
      ),
    ),

  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: appPrimaryColor,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: appPrimaryColor.withOpacity(.2),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
      ),
    ),
  );

  static Color appWhiteColor = Color(0xFFFFFFFF);
  static Color appBlackColor = Color(0xFF000000);

  static Color appPrimaryColor = Color(0xFF5846C8);
  static Color appPrimaryLightColor = Color(0xFFDAE8F5);
  static Color appLightTextColor = Color(0xFF0C2052);
  static Color subTextColor = Color(0xFFA7BEE9);
}