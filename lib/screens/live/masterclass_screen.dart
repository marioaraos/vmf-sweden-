import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class MasterclassScreen extends StatefulWidget {
  const MasterclassScreen({super.key});

  @override
  State<MasterclassScreen> createState() => _MasterclassScreenState();
}

class _MasterclassScreenState extends State<MasterclassScreen> {
  late VideoPlayerController _controller;
  bool _isLive = true;

  @override
  void initState() {
    super.initState();
    // Reutilizamos el motor de video para simular el Live Stream de Shortzz
    _controller = VideoPlayerController.asset('assets/videos/intro_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. MOTOR DE VIDEO (SIMULANDO LIVE STREAM)
          if (_controller.value.isInitialized)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            )
          else
            const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37))),

          // 2. GRADIENTE DE TEATRO (LUXY STYLE)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          // 3. UI DE MASTERCLASS (CONCIERGE STYLE)
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                const Spacer(),
                _buildAudienceOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "LIVE MASTERCLASS",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const CircleAvatar(
            backgroundColor: Colors.white10,
            child: Icon(Icons.share_outlined, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildAudienceOverlay() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          border: const Border(top: BorderSide(color: Colors.white10, width: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFD4AF37)),
                    image: const DecorationImage(image: AssetImage('assets/images/logo.png'), fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("VMF FOUNDER", style: GoogleFonts.playfairDisplay(color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                    Text("1,240 MIEMBROS VIENDO", style: GoogleFonts.inter(color: Colors.white38, fontSize: 10, letterSpacing: 1)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "El Legado de la Excelencia: Construyendo el Futuro de VMF Sweden.",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text("Hacer una pregunta...", style: TextStyle(color: Colors.white38, fontSize: 12)),
                  ),
                ),
                const SizedBox(width: 15),
                // Botón de Ofrendas (Gifting de Shortzz)
                GestureDetector(
                  onTap: () => _showOfferingModal(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFD4AF37),
                    ),
                    child: const Icon(Icons.stars_rounded, color: Colors.black, size: 24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOfferingModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F).withOpacity(0.9),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.1)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("SEMBRAR SEMILLA", style: GoogleFonts.inter(color: const Color(0xFFD4AF37), letterSpacing: 5, fontSize: 14)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildOfferingOption("100", "BRONCE"),
                  _buildOfferingOption("500", "PLATA"),
                  _buildOfferingOption("1000", "ORO"),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferingOption(String amount, String level) {
    return Column(
      children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
          ),
          child: const Icon(Icons.workspace_premium_rounded, color: Color(0xFFD4AF37)),
        ),
        const SizedBox(height: 10),
        Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        Text(level, style: const TextStyle(color: Colors.white38, fontSize: 8)),
      ],
    );
  }
}
