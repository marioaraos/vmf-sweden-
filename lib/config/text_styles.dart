import 'package:flutter/material.dart';
import 'palette.dart';

class LuxyText {
  static const String font = 'Roboto'; // Matching the user's main.dart font for consistency

  static TextStyle heading1 = const TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: LuxyPalette.white,
    letterSpacing: -0.5,
  );
  
  static TextStyle heading2 = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: LuxyPalette.white,
  );
  
  static TextStyle body = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: LuxyPalette.grey200,
  );
  
  static TextStyle caption = const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: LuxyPalette.grey600,
  );
  
  static TextStyle goldHeading = const TextStyle(
    color: Color(0xFFD4AF37),
    fontSize: 24,
    letterSpacing: 16,
    fontWeight: FontWeight.w200,
  );
}
