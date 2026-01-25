import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VaultScreen extends StatelessWidget {
  const VaultScreen({super.key});

  static const Color _gold = Color(0xFFD4AF37);

  @override
  Widget build(BuildContext context) {
    final clips = const [
      'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1506157786151-b8491531f063?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1492684223066-81342ee5ff30?q=80&w=1200&auto=format&fit=crop',
      'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?q=80&w=1200&auto=format&fit=crop',
    ];

    final docs = const [
      _VaultDoc(title: 'GUIA LUX #0', size: 'PDF - 2.4 MB'),
      _VaultDoc(title: 'GUIA LUX #1', size: 'PDF - 2.4 MB'),
      _VaultDoc(title: 'GUIA LUX #2', size: 'PDF - 2.4 MB'),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: _gold, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LA BOVEDA',
              style: GoogleFonts.playfairDisplay(
                color: _gold,
                fontSize: 28,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'RECURSOS Y CLIPS EXCLUSIVOS',
              style: GoogleFonts.inter(
                color: Colors.white54,
                fontSize: 12,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 28),
            _sectionTitle('CLIPS DESTACADOS'),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: clips.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.05,
              ),
              itemBuilder: (context, index) => _buildClipCard(clips[index]),
            ),
            const SizedBox(height: 32),
            _sectionTitle('BIBLIOTECA DE ORO'),
            const SizedBox(height: 16),
            Column(
              children: docs.map(_buildDocCard).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: _gold,
        fontSize: 14,
        letterSpacing: 4,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildClipCard(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.4),
                border: Border.all(color: Colors.white70, width: 2),
              ),
              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard(_VaultDoc doc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF171717),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doc.size,
                  style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _gold.withOpacity(0.7)),
            ),
            child: const Icon(Icons.download_rounded, color: _gold, size: 18),
          ),
        ],
      ),
    );
  }
}

class _VaultDoc {
  final String title;
  final String size;
  const _VaultDoc({required this.title, required this.size});
}
