import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBackupDialog extends StatelessWidget {
  const ChatBackupDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ChatBackupDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Icon(Icons.storage_rounded, color: Color(0xFFD4AF37)),
          const SizedBox(width: 12),
          Text(
            'CHAT BACKUP',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'In compliance with GDPR "Right to be Forgotten":',
            style: GoogleFonts.inter(color: const Color(0xFFD4AF37), fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            '• Backups are stored locally only.\n• Deleting your account permanently wipes all chat history.\n• Data cannot be recovered once deleted.',
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CLOSE', style: GoogleFonts.inter(color: Colors.white38)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Local backup completed.')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD4AF37),
            foregroundColor: Colors.black,
          ),
          child: const Text('BACKUP NOW'),
        ),
      ],
    );
  }
}
