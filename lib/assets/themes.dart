// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData myTheme = ThemeData(
  appBarTheme: AppBarTheme(color: Color(0xFF1f2024)),
  primaryColor: Color(0xFF111719),
  focusColor: Color(0x115e82),
  textTheme: GoogleFonts.montserratTextTheme().copyWith(
    bodyLarge: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
    titleSmall: TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  ),
);
