import 'package:example/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var welcomeTextStyle = GoogleFonts.poppins(fontSize: 24,);
var quoteStyle = GoogleFonts.poppins(
    fontSize: 16, color: textQuoteColor, letterSpacing: 1, height: 1.2);
var quoteAuthorStyle = GoogleFonts.poppins(fontSize: 16, color: textQuoteColor);
var selectCategory = GoogleFonts.poppins(
    fontSize: 18,
    // fontWeight: FontWeight.bold,
    letterSpacing: 1,
    fontWeight: FontWeight.w600);
var categoryName = GoogleFonts.poppins(
    fontSize: 20, color: white, fontWeight: FontWeight.bold);
var playerNameStyle =
    welcomeTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold);
var greetingStyle = TextStyle(fontSize: 16);
