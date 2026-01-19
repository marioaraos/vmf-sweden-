import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({Key? key}) : super(key: key);

  @override
  _FaceVerificationScreenState createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> {
  int _attempts = 0;
  bool _isProcessing = false;
  String _statusMessage = 'Align your face within the frame';

  void _startVerification() {
    setState(() {
      _isProcessing = true;
      _statusMessage = 'Analyzing features...';
    });

    // Simulate verification process
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _attempts++;
        _isProcessing = false;
        
        if (_attempts >= 3) {
          _showManualReviewDialog();
        } else {
          _statusMessage = 'Verification failed. Try again ($_attempts/3)';
        }
      });
    });
  }

  void _showManualReviewDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'MANUAL REVIEW REQUIRED',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        content: Text(
          'Verification failed 3 times. Your profile has been sent for manual review. This process takes 24-48 hours.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to profile
              },
              child: Text(
                'UNDERSTOOD',
                style: GoogleFonts.inter(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'IDENTITY VERIFICATION',
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Prove you are real to get the Verified Badge.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          // Camera Frame Simulation
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 280,
                  height: 380,
                  decoration: BoxDecoration(
                    border: Border.all(color: _isProcessing ? const Color(0xFFD4AF37) : Colors.white24, width: 2),
                    borderRadius: BorderRadius.circular(140),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(140),
                    child: Container(
                      color: Colors.white.withOpacity(0.05),
                      child: _isProcessing 
                        ? const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)))
                        : const Icon(Icons.face_retouching_natural, color: Colors.white10, size: 120),
                    ),
                  ),
                ),
                // Scanning animation line (if processing)
                if (_isProcessing)
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Positioned(
                        top: 380 * value,
                        child: Container(
                          width: 280,
                          height: 2,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.5), blurRadius: 10, spreadRadius: 2),
                            ],
                            color: const Color(0xFFD4AF37),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            _statusMessage,
            style: GoogleFonts.inter(
              color: _attempts > 0 ? Colors.redAccent : const Color(0xFFD4AF37),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _startVerification,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  disabledBackgroundColor: Colors.white10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  _isProcessing ? 'VERIFYING...' : 'TAKE PHOTO',
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
