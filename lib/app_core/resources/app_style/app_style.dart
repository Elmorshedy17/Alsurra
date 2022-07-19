import 'package:flutter/material.dart';

abstract class AppStyle {
  static const Color mainAppColor = Color(0xffFFFEFE);
  static const Color orange = Color(0xffff7114);
  static const Color red = Color(0xffFF4141);
  static const Color lightRed = Color(0xffe4706c);
  static const Color darkRed = Color(0xffE40500);
  static const Color green = Color(0xff23C38E);
  static const Color lighterRed = Color(0xffFFE5E8);
  static const Color lightGrey = Color(0xffCECFD2);
  static const Color cyanDark = Color(0xff109eb1);
  static const Color cyanLight = Color(0xffdef2f4);

  /// alsurrah

  static const Color darkOrange = Color(0xffe94b39);
  static const Color darkGrey = Color(0xff4F4F4F);
  static const Color mediumGrey = Color(0xff7D7E80);

  ////////////////////////////////////////////////
  ///To turn any color to material.
////////////////////////////////////////////////
  static Map<int, Color> color = {
    50: const Color.fromRGBO(9, 78, 143, 0.1),
    100: const Color.fromRGBO(9, 78, 143, 0.2),
    200: const Color.fromRGBO(9, 78, 143, 0.3),
    300: const Color.fromRGBO(9, 78, 143, 0.4),
    400: const Color.fromRGBO(9, 78, 143, 0.5),
    500: const Color.fromRGBO(9, 78, 143, 0.6),
    600: const Color.fromRGBO(9, 78, 143, 0.7),
    700: const Color.fromRGBO(9, 78, 143, 0.8),
    800: const Color.fromRGBO(9, 78, 143, 0.9),
    900: const Color.fromRGBO(9, 78, 143, 1),
  };

  static MaterialColor appColor = MaterialColor(0xff122940, color);
  // static MaterialColor appColor = MaterialColor(0xffFFFEFE, color);
  static const String fontAR = 'AR';
  static const String fontEN = 'EN';
}

///
///
///
