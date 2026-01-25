import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SanctuaryScreen extends StatelessWidget {
  const SanctuaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "SANTUARIO",
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Proximamente tendremos contenido exclusivo para el santuario.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white54, fontSize: 14, height: 1.5),
          ),
        ),
      ),
    );
  }
}
