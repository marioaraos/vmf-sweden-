import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:vmf_lux_project/config/palette.dart';
import 'package:vmf_lux_project/widgets/super_like_particles.dart';

class SoulResonanceOverlay extends StatelessWidget {
  final String user1Photo;
  final String user2Photo;
  final String user2Name;

  const SoulResonanceOverlay({
    Key? key,
    required this.user1Photo,
    required this.user2Photo,
    required this.user2Name,
  }) : super(key: key);

  static void show(BuildContext context, {required String user1Photo, required String user2Photo, required String user2Name}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.9),
      transitionDuration: const Duration(milliseconds: 800),
      pageBuilder: (context, anim1, anim2) => SoulResonanceOverlay(
        user1Photo: user1Photo,
        user2Photo: user2Photo,
        user2Name: user2Name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Fondo de partículas espirituales
          const SuperLikeParticles(active: true),
          
          // Efecto de desenfoque de fondo
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),

          Column(
            mainAxisAlignment: MainStateAxisAlignment.center,
            children: [
              // Geometría Sagrada (Simulada con un icono o imagen)
              Icon(
                Icons.auto_awesome_outlined,
                color: LuxyPalette.gold500.withOpacity(0.3),
                size: 300,
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SOUL RESONANCE',
                style: GoogleFonts.playfairDisplay(
                  color: LuxyPalette.gold500,
                  fontSize: 28,
                  letterSpacing: 8,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'YOUR AURAS HAVE ALIGNED',
                style: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 10,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 60),
              
              // Fotos alineadas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAuraAvatar(user1Photo),
                  const SizedBox(width: -20), // Solapamiento elegante
                  _buildAuraAvatar(user2Photo),
                ],
              ),
              
              const SizedBox(height: 60),
              Text(
                'You and $user2Name share a\ndivine frequency.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Botones de acción mística
              _buildActionButton(
                context,
                'SEND A MESSAGE',
                onTap: () => Navigator.pop(context),
                isPrimary: true,
              ),
              const SizedBox(height: 20),
              _buildActionButton(
                context,
                'STAY IN THE SANCTUARY',
                onTap: () => Navigator.pop(context),
                isPrimary: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAuraAvatar(String photoUrl) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: LuxyPalette.gold500, width: 2),
        boxShadow: [
          BoxShadow(
            color: LuxyPalette.gold500.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(photoUrl, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, {required VoidCallback onTap, required bool isPrimary}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isPrimary ? LuxyPalette.gold500 : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: isPrimary ? null : Border.all(color: Colors.white24),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: isPrimary ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
