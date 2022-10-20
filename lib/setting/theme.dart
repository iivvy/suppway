import 'package:flutter/material.dart';

enum AppTheme { light, dark }

final appThemeData = {
  AppTheme.light: ThemeData(
    fontFamily: "Barlow",
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(41, 70, 181, 1.0),
    ),
    primaryColor: const Color.fromRGBO(41, 70, 181, 1.0),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Color.fromRGBO(41, 70, 181, 1.0),
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarHeight: 70.0,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(
      //     bottom: Radius.circular(10),
      //   ),
      // ),
      // flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       borderRadius: const BorderRadius.only(
      //         bottomLeft: Radius.circular(10.0),
      //         bottomRight: Radius.circular(10.0),
      //       ),
      //       gradient: colorGradient(_theme),
      //     ),
      //   ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(41, 70, 181, 1.0)),
        side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        )),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.black,
      focusColor: Colors.black,
      hoverColor: Colors.black,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(color: Colors.black, fontSize: 18.0),
      errorStyle: TextStyle(
        color: Colors.red.shade900,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color.fromRGBO(41, 70, 181, 1.0),
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 25.0,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
      headline4: TextStyle(
        color: Color.fromRGBO(41, 70, 181, 1.0),
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
      ),
      headline6: TextStyle(color: Colors.black, fontSize: 17.0),

      //  subtitle1: TextStyle(color: Colors.black, fontSize: 18.0),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.circular(30),
        ),
      ),
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 18.0,
      ),
      contentTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 13.0,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.green.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    ),
    chipTheme: const ChipThemeData(
      showCheckmark: false,
      backgroundColor: Colors.white,
      disabledColor: Colors.white,
      selectedColor: Colors.lightBlue,
      secondarySelectedColor: Colors.lightBlue,
      padding: EdgeInsets.all(10.0),
      labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),
      secondaryLabelStyle: TextStyle(color: Colors.lightBlue),
      brightness: Brightness.light,
      elevation: 5.0,
    ),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      // shadowColor: Colors.lightGreen,
      elevation: 2.0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color.fromRGBO(41, 70, 181, 1.0),
      unselectedItemColor: Colors.black38,
      selectedIconTheme: IconThemeData(
        color: Color.fromRGBO(41, 70, 181, 1.0),
      ),
      unselectedIconTheme: IconThemeData(
        color: Colors.black38,
      ),
      selectedLabelStyle: TextStyle(
        color: Color.fromRGBO(41, 70, 181, 1.0),
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.black38,
      ),
    ),
  ),
  AppTheme.dark: ThemeData(
    colorScheme: const ColorScheme.dark(),
    primaryColor: Colors.black,
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      toolbarHeight: 70.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.indigo.shade100),
        side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        )),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      focusColor: Colors.white,
      hoverColor: Colors.white,
      hintStyle: const TextStyle(
        color: Colors.grey,
      ),
      labelStyle: const TextStyle(color: Colors.white, fontSize: 18.0),
      errorStyle: TextStyle(
        color: Colors.red.shade900,
      ),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.indigo.shade400,
        fontSize: 15.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: const TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.w700,
      ),
      headline3: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
      headline4: TextStyle(
        color: Colors.indigo.shade100,
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      ),
      headline5: const TextStyle(
        color: Colors.white,
        fontSize: 13.0,
      ),
      headline6: const TextStyle(color: Colors.white, fontSize: 17.0),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.circular(30),
        ),
      ),
      titleTextStyle: TextStyle(
        color: Colors.green,
        fontSize: 18.0,
      ),
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 13.0,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.green.shade50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
    ),
    chipTheme: const ChipThemeData(
      showCheckmark: false,
      backgroundColor: Colors.white,
      disabledColor: Colors.white,
      selectedColor: Colors.lightBlue,
      secondarySelectedColor: Colors.lightBlue,
      padding: EdgeInsets.all(10.0),
      labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),
      secondaryLabelStyle: TextStyle(color: Colors.lightBlue),
      brightness: Brightness.light,
      elevation: 5.0,
    ),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      // shadowColor: Colors.lightGreen,
      elevation: 2.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black12,
      selectedItemColor: Colors.indigo.shade100,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(
        color: Colors.indigo.shade100,
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      selectedLabelStyle: TextStyle(
        color: Colors.indigo.shade100,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
  ),
};
