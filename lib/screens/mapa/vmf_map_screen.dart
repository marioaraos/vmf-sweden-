import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';

class VMFMapScreen extends StatelessWidget {
  const VMFMapScreen({super.key});

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
          "VMF GLOBAL MAP",
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
          // SIMULACIÓN DE MAPA ESTILIZADO (Estética de Discover migrada)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/logo.png'), // Aquí iría el mapa oscuro
                opacity: 0.05,
                fit: BoxFit.contain,
              ),
            ),
          ),
          
          // CAPA DE CRISTAL PARA EL DESCUBRIMIENTO
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.2)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "DESCUBRE EL LEGADO",
                        style: GoogleFonts.inter(color: const Color(0xFFD4AF37), letterSpacing: 3, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      _buildExploreItem("STOCKHOLM, SWEDEN", "Legacy Project Alpha"),
                      const SizedBox(height: 10),
                      _buildExploreItem("MALAWI, AFRICA", "VMF Impact School"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreItem(String location, String project) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: Color(0xFFD4AF37), size: 18),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(location, style: GoogleFonts.inter(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            Text(project, style: GoogleFonts.inter(color: Colors.white38, fontSize: 10)),
          ],
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios, color: Colors.white10, size: 12),
      ],
    );
  }
}
