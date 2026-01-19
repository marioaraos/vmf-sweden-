import 'package:flutter/material.dart';

class LuxyPalette {
  LuxyPalette._();
  static const Color gold900   = Color(0xFF6B4E00);
  static const Color gold700   = Color(0xFFAB7C00);
  static const Color gold500   = Color(0xFFFFC700);
  static const Color gold200   = Color(0xFFFFE08A);
  static const Color black     = Color(0xFF121212);
  static const Color grey900   = Color(0xFF1E1E1E);
  static const Color grey800   = Color(0xFF2C2C2C);
  static const Color grey600   = Color(0xFF5C5C5C);
  static const Color grey200   = Color(0xFFEDEDED);
  static const Color white     = Color(0xFFFFFFFF);

  static const Gradient goldGradient = LinearGradient(
    colors: [gold500, gold700],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient blackFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black87, Colors.black],
  );
}
