import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'COMUNIDAD',
          style: GoogleFonts.inter(
            color: goldColor,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('ANUNCIOS VMF', goldColor),
            const SizedBox(height: 12),
            _buildAnnouncementCard('Nueva Alianza con Ritz-Carlton', 'Beneficios exclusivos para miembros VMF.'),
            const SizedBox(height: 30),
            _sectionHeader('PRÓXIMOS EVENTOS', goldColor),
            const SizedBox(height: 12),
            _buildCommunityItem('Black-tie Party', 'The Ritz, Madrid', '24 Oct'),
            _buildCommunityItem('Yacht Networking', 'Puerto Banús', '12 Nov'),
            const SizedBox(height: 30),
            _sectionHeader('ACTIVIDADES', goldColor),
            const SizedBox(height: 12),
            _buildCommunityItem('Cata de Vinos Premium', 'Online', '15 Oct'),
            _buildCommunityItem('Masterclass: Liderazgo', 'Live Stream', '20 Oct'),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, Color goldColor) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: goldColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildAnnouncementCard(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCommunityItem(String title, String location, String date) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Icon(Icons.calendar_month, color: Color(0xFFD4AF37))),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                Text('$location • $date', style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 14),
        ],
      ),
    );
  }
}
