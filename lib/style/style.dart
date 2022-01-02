import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color accentColor = Color(0xFFFEEBED);
final Color primaryColor = Color(0xFFF1323E);

final TextTheme cookiezTextTheme = TextTheme(
  headline1: GoogleFonts.viga(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.viga(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.viga(
      fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.viga(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.viga(
      fontSize: 23, fontWeight: FontWeight.w700, color: Colors.black),
  headline6: GoogleFonts.viga(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15,  color: accentColor),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w300, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
