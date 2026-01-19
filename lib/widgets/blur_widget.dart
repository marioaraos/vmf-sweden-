import 'dart:ui';
import 'package:flutter/material.dart';
import '../config/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class BlurWidget extends StatelessWidget {
  final Widget child;

  const BlurWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          child,
          // Capa de desenfoque
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: LuxyPalette.black.withOpacity(0.4),
              ),
            ),
          ),
          // Mensaje de bloqueo exclusivo
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, color: LuxyPalette.gold500, size: 40),
                const SizedBox(height: 10),
                Text("EXCLUSIVE CONTENT",
                    style: GoogleFonts.inter(color: LuxyPalette.gold500, fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
                const SizedBox(height: 5),
                Text("Upgrade to BLACK",
                    style: GoogleFonts.inter(color: Colors.white70, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}