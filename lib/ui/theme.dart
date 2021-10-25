import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoso/ui/constants/constants.dart';

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      brightness: Brightness.light,
      backgroundColor: Colors.white);

  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      brightness: Brightness.dark,
      backgroundColor: darkGreyClr);
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  ));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
  ));
}
