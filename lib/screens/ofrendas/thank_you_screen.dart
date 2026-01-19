import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class ThankYouScreen extends StatelessWidget {
  final String title;
  final String amount;

  const ThankYouScreen({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C),
      body: Stack(
        children: [
          // Aura de fondo
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.1),
                    blurRadius: 150,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono Espiritual Lux
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.scale(
                          scale: value,
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3), width: 1),
                              gradient: RadialGradient(
                                colors: [
                                  const Color(0xFFD4AF37).withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFFD4AF37),
                              size: 80,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 50),

                  Text(
                    'GRACIAS POR TU OFRENDA',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: const Color(0xFFD4AF37),
                      fontSize: 24,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    title.toUpperCase(),
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 14,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    amount,
                    style: GoogleFonts.inter(
                      color: Colors.white38,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 80),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Tu semilla ha sido recibida y registrada en el legado de VMF Sweden.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.white24,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  GestureDetector(
                    onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
                      ),
                      child: Text(
                        "VOLVER AL SANTUARIO",
                        style: GoogleFonts.inter(
                          color: const Color(0xFFD4AF37),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
