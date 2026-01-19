import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class VMFHistoryScreen extends StatelessWidget {
  const VMFHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "VMF HISTORY",
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            fontSize: 14,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Fondo con textura de lujo (Simulación de Feed de Shortzz)
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _buildHistoryItem(
                context,
                "CAPÍTULO ${index + 1}",
                "202${5 - index}",
                "Explorando el crecimiento global y el impacto de nuestra red exclusiva en Europa y el mundo.",
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, String title, String year, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(year, style: GoogleFonts.playfairDisplay(color: const Color(0xFFD4AF37), fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(width: 20),
              Container(width: 40, height: 1, color: Colors.white10),
            ],
          ),
          const SizedBox(height: 10),
          Text(title, style: GoogleFonts.inter(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 15),
          Text(
            content,
            style: GoogleFonts.inter(color: Colors.white54, fontSize: 13, height: 1.6),
          ),
          const SizedBox(height: 25),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              'assets/images/logo.png', // Placeholder para imágenes de historia
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white10),
        ],
      ),
    );
  }
}
