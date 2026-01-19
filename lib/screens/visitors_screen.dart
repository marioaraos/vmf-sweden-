import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vmf_lux_project/widgets/luxy_black_modal.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPremium = false; // This would come from a provider or state

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'VISITORS',
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              return _buildVisitorItem(context, index, isPremium);
            },
          ),
          if (!isPremium)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.8),
                      Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.lock_outline, color: Color(0xFFD4AF37), size: 48),
                    const SizedBox(height: 20),
                    Text(
                      'SEE WHO VISITED YOU',
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Luxy BLACK members can see everyone who viewed their profile in the last 72 hours.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(color: Colors.white54, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => LuxyBlackModal.show(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          child: Text(
                            'GET LUXY BLACK',
                            style: GoogleFonts.inter(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVisitorItem(BuildContext context, int index, bool isPremium) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?u=$index'),
                fit: BoxFit.cover,
                colorFilter: isPremium ? null : const ColorFilter.mode(Colors.black, BlendMode.saturation),
              ),
            ),
            child: isPremium ? null : const Icon(Icons.blur_on, color: Colors.white24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isPremium ? 'User $index' : '••••••••',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Visited 2h ago',
                  style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          if (isPremium)
            const Icon(Icons.chat_bubble_outline, color: Color(0xFFD4AF37), size: 20)
          else
            const Icon(Icons.lock_outline, color: Colors.white10, size: 20),
        ],
      ),
    );
  }
}
