import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColorRed = Color(0xff353538);
  static const Color primaryColorGray = Color(0xff9B9B9B);
  static const Color primarynormal = Color(0xDD000000);

  static const kSecondaryColor = Color(0xFF979797);
  static const kTextColor = Color(0xFF757575);
  static const kwhite = Color(0xFFffffff);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}