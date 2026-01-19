import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportModal extends StatelessWidget {
  final String targetUserName;
  const ReportModal({Key? key, required this.targetUserName}) : super(key: key);

  static void show(BuildContext context, String userName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ReportModal(targetUserName: userName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reasons = [
      'Fake Profile',
      'Scam / Commercial',
      'Sugar Dating',
      'Harassment',
      'Hate Speech',
      'Under-age'
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'REPORT ${targetUserName.toUpperCase()}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Please select the reason for reporting this user.',
            style: GoogleFonts.inter(color: Colors.white38, fontSize: 12),
          ),
          const SizedBox(height: 20),
          ...reasons.map((reason) => ListTile(
                title: Text(
                  reason,
                  style: GoogleFonts.inter(color: Colors.white70, fontSize: 15),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white24),
                onTap: () {
                  // Handle report logic here
                  Navigator.pop(context);
                  _showConfirmation(context);
                },
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFD4AF37),
        content: Text(
          'Thank you. Report for $targetUserName submitted.',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
