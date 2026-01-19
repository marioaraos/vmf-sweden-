import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LuxyBlackModal extends StatelessWidget {
  const LuxyBlackModal({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LuxyBlackModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Color(0xFFD4AF37), blurRadius: 20, spreadRadius: -10),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 40),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFD4AF37), Color(0xFFFFE08A), Color(0xFFAB7C00)],
            ).createShader(bounds),
            child: Text(
              'LUXY BLACK',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'ELITE STATUS UNLOCKED',
            style: GoogleFonts.inter(
              fontSize: 12,
              letterSpacing: 4,
              color: const Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                _buildFeatureRow(Icons.favorite_rounded, 'Who Liked Me', 'See everyone who swiped right on you.'),
                _buildFeatureRow(Icons.tune_rounded, 'Advanced Filters', 'Filter by income, location, and more.'),
                _buildFeatureRow(Icons.visibility_off_rounded, 'Private Mode', 'Browse anonymously and hide your profile.'),
                _buildFeatureRow(Icons.star_rounded, 'Unlimited Super-Likes', 'Stand out from the crowd every day.'),
                _buildFeatureRow(Icons.remove_red_eye_rounded, 'Visitors', 'See who visited your profile in the last 72h.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFD4AF37), Color(0xFFAB7C00)],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implementation for purchase
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      'UPGRADE NOW • \$12.99/MO',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'MAYBE LATER',
                    style: GoogleFonts.inter(color: Colors.white38, fontSize: 11, letterSpacing: 2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.1)),
            ),
            child: Icon(icon, color: const Color(0xFFD4AF37), size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
