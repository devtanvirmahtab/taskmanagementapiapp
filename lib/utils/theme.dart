import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lightTheme (BuildContext context) => ThemeData(
    scaffoldBackgroundColor: appPrimaryLightColor,
    brightness: Brightness.light,
    primaryColor: appPrimaryColor,
    bottomAppBarColor: appPrimaryColor,
    focusColor: appPrimaryLightColor,
    textTheme: TextTheme(
      headline1: TextStyle(color: appLightTextColor.withOpacity(.8),fontSize: 20,fontWeight: FontWeight.w700),
      headline2: TextStyle(color: appLightTextColor.withOpacity(.8),fontSize: 15,fontWeight: FontWeight.w700),
      subtitle1: TextStyle(color: appLightTextColor.withOpacity(.7),fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: appPrimaryColor
      ),
        color: appPrimaryColor,
        titleTextStyle: TextStyle(
          color: appPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w700
        )
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
    scaffoldBackgroundColor: appDarkScaffoldColor,
    canvasColor: appCanvasColor,
    primaryColor: appDarkPrimaryColor,
    cardColor: appPrimaryColor.withOpacity(.08),
    focusColor: appPrimaryLightColor,
    textTheme: TextTheme(
      headline1: TextStyle(color: titleTextColor,fontSize: 20,fontWeight: FontWeight.w700),
      headline2: TextStyle(color: titleTextColor,fontSize: 15,fontWeight: FontWeight.w700),
      subtitle1: TextStyle(color: subTextColor.withOpacity(.7),fontSize: 14),
    ),
    brightness: Brightness.dark,
    bottomAppBarColor: appPrimaryColor.withOpacity(.1),
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

  static const appPrimaryColor = Color(0xFF2196F3);
  static Color appDarkPrimaryColor = Color(0xFFffffff);
  static Color appDarkScaffoldColor = Color(0xFF0C1421);
  static Color appCardColor = Color(0xFF03263D);
  static Color appCanvasColor = Color(0xFF05103C);
  static Color appPrimaryLightColor = Color(0xFFDAE8F5);
  static Color appLightTextColor = Color(0xFF0C2052);
  static Color titleTextColor = Color(0xFFD0D0FC);
  static Color subTextColor = Color(0xFF818191);
}