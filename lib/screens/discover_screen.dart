import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vmf_lux_project/widgets/luxy_black_modal.dart';
import 'package:vmf_lux_project/widgets/report_modal.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final List<Map<String, dynamic>> _profiles = [
    {
      'name': 'Alexandra',
      'age': 28,
      'job': 'Investment Banker',
      'income': '250k+',
      'verified': true,
      'image': 'https://images.unsplash.com/photo-1494790108377-be9ce29b2933?q=80&w=1000&auto=format&fit=crop',
    },
    {
      'name': 'Isabella',
      'age': 31,
      'job': 'Creative Director',
      'income': '500k+',
      'verified': true,
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1000&auto=format&fit=crop',
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= _profiles.length) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.refresh, color: Color(0xFFD4AF37), size: 40),
              const SizedBox(height: 16),
              Text('No more profiles in your area', style: GoogleFonts.inter(color: Colors.white54)),
              TextButton(
                onPressed: () => setState(() => _currentIndex = 0),
                child: const Text('Reset', style: TextStyle(color: Color(0xFFD4AF37))),
              ),
            ],
          ),
        ),
      );
    }

    final profile = _profiles[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Profile Image
          Positioned.fill(
            child: Image.network(
              profile['image'],
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          // Top Actions
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.tune, color: Colors.white),
                  onPressed: () => LuxyBlackModal.show(context),
                ),
                Text(
                  'DISCOVER',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    letterSpacing: 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz, color: Colors.white),
                  onPressed: () => ReportModal.show(context, profile['name']),
                ),
              ],
            ),
          ),
          // Profile Info
          Positioned(
            bottom: 120,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${profile['name']}, ${profile['age']}',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (profile['verified'])
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.verified, color: Color(0xFFD4AF37), size: 24),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.work_outline, color: Colors.white70, size: 16),
                    const SizedBox(width: 8),
                    Text(profile['job'], style: GoogleFonts.inter(color: Colors.white70, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined, color: Color(0xFFD4AF37), size: 16),
                    const SizedBox(width: 8),
                    Text(profile['income'], style: GoogleFonts.inter(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(Icons.close, Colors.white, () {
                  setState(() => _currentIndex++);
                }),
                const SizedBox(width: 20),
                _buildActionButton(Icons.star, const Color(0xFFD4AF37), () {
                  LuxyBlackModal.show(context); // Second Super-Like logic
                }, isLarge: true),
                const SizedBox(width: 20),
                _buildActionButton(Icons.favorite, const Color(0xFFD4AF37), () {
                  setState(() => _currentIndex++);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap, {bool isLarge = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isLarge ? 75 : 60,
        height: isLarge ? 75 : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.5),
          border: Border.all(color: color.withOpacity(0.5), width: 1),
        ),
        child: Icon(icon, color: color, size: isLarge ? 35 : 28),
      ),
    );
  }
}
