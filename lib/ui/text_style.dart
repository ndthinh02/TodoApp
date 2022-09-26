import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';

class MyTextStyle {
  bool isDarkTheme;
  TextStyle get titleBar {
    return GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: isDarkTheme ? Colors.white : Colors.black);
  }

  TextStyle get titleStyle {
    return GoogleFonts.lato(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDarkTheme ? Colors.white : Colors.black);
  }

  TextStyle get subStyle {
    return GoogleFonts.lato(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: isDarkTheme ? Colors.white : Colors.black);
  }

  MyTextStyle({required this.isDarkTheme});
}
