import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/palette.dart';
import '../widgets/blur_widget.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const bool isBlackMember = false; // Simulación de estado

    return Scaffold(
      backgroundColor: LuxyPalette.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Likes', style: GoogleFonts.playfairDisplay(color: LuxyPalette.gold500)),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          Widget card = _buildLikedCard();
          return isBlackMember ? card : BlurWidget(child: card);
        },
      ),
    );
  }

  Widget _buildLikedCard() => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: LuxyPalette.gold500.withOpacity(0.5)),
      image: const DecorationImage(
        image: AssetImage('assets/images/mujer.png'), // Usando tus assets
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LuxyPalette.blackFade,
      ),
      padding: const EdgeInsets.all(12),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text('User Name, 24',
            style: GoogleFonts.inter(color: LuxyPalette.white, fontWeight: FontWeight.bold)),
      ),
    ),
  );
}