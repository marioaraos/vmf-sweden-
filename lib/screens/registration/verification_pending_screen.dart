import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationPendingScreen extends StatefulWidget {
  const VerificationPendingScreen({Key? key}) : super(key: key);

  @override
  State<VerificationPendingScreen> createState() => _VerificationPendingScreenState();
}

class _VerificationPendingScreenState extends State<VerificationPendingScreen> {
  static const Duration _reviewDuration = Duration(hours: 24);
  static const String _deadlineKey = 'verification_deadline_ms';

  Timer? _ticker;
  DateTime? _deadline;
  Duration _remaining = _reviewDuration;
  bool _isReady = false;

  final Color _champagne = const Color(0xFFE7D3A3);
  final Color _gold = const Color(0xFFD4AF37);
  final Color _deepBlack = const Color(0xFF060606);

  @override
  void initState() {
    super.initState();
    _initDeadline();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _initDeadline() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now();
      final stored = prefs.getInt(_deadlineKey);
      DateTime deadline;
      if (stored != null) {
        deadline = DateTime.fromMillisecondsSinceEpoch(stored);
      } else {
        deadline = now.add(_reviewDuration);
        await prefs.setInt(_deadlineKey, deadline.millisecondsSinceEpoch);
      }
      _deadline = deadline;
      _remaining = _sanitizeDuration(deadline.difference(now));
      _isReady = true;
      _startTicker();
      if (mounted) setState(() {});
    } catch (_) {
      _deadline = DateTime.now().add(_reviewDuration);
      _remaining = _reviewDuration;
      _isReady = true;
      _startTicker();
      if (mounted) setState(() {});
    }
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _deadline == null) return;
      final diff = _deadline!.difference(DateTime.now());
      setState(() => _remaining = _sanitizeDuration(diff));
    });
  }

  Duration _sanitizeDuration(Duration duration) {
    return duration.isNegative ? Duration.zero : duration;
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final File? profileImage = args is File ? args : null;
    return Scaffold(
      backgroundColor: _deepBlack,
      body: Stack(
        children: [
          const _LuxyBackdrop(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 30),
                  Text(
                    'Verification in progress',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Every member is carefully reviewed to keep Luxy exclusive.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white54,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 26),
                  _buildCountdownCard(profileImage),
                  const Spacer(),
                  _buildPrimaryCta(context),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _showNotifyMessage,
                    child: Text(
                      'Notify me',
                      style: GoogleFonts.inter(
                        color: _champagne,
                        fontSize: 13,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/videos/logo.png',
      height: 36,
      color: _champagne,
      errorBuilder: (context, error, stackTrace) => Text(
        'LUXY',
        style: GoogleFonts.playfairDisplay(
          color: _champagne,
          fontSize: 22,
          letterSpacing: 6,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildCountdownCard(File? profileImage) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _champagne.withOpacity(0.25), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: _gold.withOpacity(0.08),
            blurRadius: 35,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          if (profileImage != null) ...[
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _champagne.withOpacity(0.6), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: _gold.withOpacity(0.2),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.file(profileImage, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 14),
          ],
          Text(
            _isReady ? 'Estimated response within 24 hours' : 'Preparing your review',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white54,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          if (_isReady)
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [_champagne, _gold, const Color(0xFFF4E7C8)],
              ).createShader(bounds),
              child: Text(
                _formatDuration(_remaining),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 36,
                  letterSpacing: 2,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
            SizedBox(
              height: 36,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_champagne),
                  strokeWidth: 2,
                ),
              ),
            ),
          const SizedBox(height: 18),
          _buildStatusRow(),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    final bool isApproved = _remaining == Duration.zero;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _StatusStep(label: 'Submitted', isActive: true, accent: _gold),
        _StatusStep(label: 'In Review', isActive: !isApproved, accent: _gold),
        _StatusStep(label: 'Approved', isActive: isApproved, accent: _gold),
      ],
    );
  }

  Widget _buildPrimaryCta(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/verification_preview'),
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_champagne, _gold],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: _gold.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Explore Preview',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  void _showNotifyMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('We will notify you as soon as review is complete.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _LuxyBackdrop extends StatelessWidget {
  const _LuxyBackdrop();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF050505),
                Color(0xFF0B0B0D),
                Color(0xFF050505),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.8, -0.6),
                radius: 1.2,
                colors: [
                  const Color(0xFF2A241B).withOpacity(0.35),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0.08,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFBFA26A),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}

class _StatusStep extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color accent;

  const _StatusStep({
    required this.label,
    required this.isActive,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isActive ? accent : Colors.white24;
    return Column(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: accent.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            color: color,
            fontSize: 10,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
