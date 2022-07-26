import 'package:appentus_project/theme/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
        primaryColor: primary,
        textTheme: TextTheme(
        subtitle1: TextStyle(
          color: black,
          fontSize: 14,
          
      ),
      // Set for App Name
      headline1: TextStyle(
          color: black,
          fontSize: 22,
           letterSpacing: 1.5,
      ),
      // Set
      headline2: TextStyle(
          color: black,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          
      ),
      // Set
      headline3: TextStyle(
          color: black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          
      ),
      headline4: TextStyle(
          color: black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          
      ),
      // set
        headline5: TextStyle(
          color: black,
          fontSize: 14,
          
      ),
      // set
      headline6: TextStyle(
          color: black,
          fontSize: 14,
          
      ),
        subtitle2: TextStyle(
          color: black,
          fontSize: 18,
          fontWeight: FontWeight.w100,
          
        ),
        bodyText1: TextStyle(
          color: textGrey,
          fontSize: 10,
          
        ),
      ),
      scaffoldBackgroundColor: white,
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: black,
          fontSize: 18,
          
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
          color: textGrey,
          fontSize: 16,
          
          fontWeight: FontWeight.w400
      ),
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: primary,
      )
    );

ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
        primaryColor: primary,
        textTheme: TextTheme(
        subtitle1: TextStyle(
          color: white,
          fontSize: 14,
          
      ),
      // Set for App Name
      headline1: TextStyle(
          color: white,
          fontSize: 22,
           letterSpacing: 1.5,
      ),
      // Set
      headline2: TextStyle(
          color: white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          
      ),
      // Set
      headline3: TextStyle(
          color: white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          
      ),
      headline4: TextStyle(
          color: white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          
      ),
      // set
        headline5: TextStyle(
          color: white,
          fontSize: 14,
          
      ),
      // set
      headline6: TextStyle(
          color: white,
          fontSize: 14,
          
      ),
        subtitle2: TextStyle(
          color: white,
          fontSize: 18,
          fontWeight: FontWeight.w100,
          
        ),
        bodyText1: TextStyle(
          color: white,
          fontSize: 10,
          
        ),
      ),
      scaffoldBackgroundColor: black,
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: white,
          fontSize: 18,
          
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: TextStyle(
          color: white,
          fontSize: 16,
          
          fontWeight: FontWeight.w400
      ),
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: primary,
      )
    );