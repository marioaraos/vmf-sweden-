import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/palette.dart';

class QrPassPage extends StatelessWidget {
  const QrPassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuxyPalette.black,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: LuxyPalette.grey900.withOpacity(0.5),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: LuxyPalette.gold500.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("EXCLUSIVE EVENT",
                  style: GoogleFonts.playfairDisplay(color: LuxyPalette.gold500, letterSpacing: 5)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: LuxyPalette.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.qr_code_scanner, size: 180, color: LuxyPalette.black),
              ),
              const SizedBox(height: 40),
              Text("VMF SWEDEN GUEST", style: GoogleFonts.inter(color: LuxyPalette.grey200, fontSize: 14)),
              const SizedBox(height: 10),
              Text("STOCKHOLM 2026", style: TextStyle(color: LuxyPalette.gold500, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}