import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/palette.dart';
import '../widgets/swipe_deck.dart';

class DiscoveryPage extends StatelessWidget {
  const DiscoveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuxyPalette.black,
      body: Column(
        children: [
          const SizedBox(height: 50),
          _header(context),
          const Spacer(),
          const SwipeDeck(),
          const Spacer(),
          _footerActions(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Discover',
            style: GoogleFonts.playfairDisplay(
                color: LuxyPalette.gold500,
                fontSize: 28,
                fontWeight: FontWeight.w300)),
        IconButton(
            icon: const Icon(Icons.tune, color: LuxyPalette.gold500),
            onPressed: () {}),
      ],
    ),
  );

  Widget _footerActions() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _circleButton(Icons.refresh, () {}),
      const SizedBox(width: 20),
      _circleButton(Icons.star, () {}, isGold: true),
      const SizedBox(width: 20),
      _circleButton(Icons.favorite, () {}),
    ],
  );

  Widget _circleButton(IconData icon, VoidCallback onTap, {bool isGold = false}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: isGold ? LuxyPalette.gold500 : LuxyPalette.grey600,
                width: 1),
          ),
          child: Icon(icon, color: isGold ? LuxyPalette.gold500 : LuxyPalette.white),
        ),
      );
}