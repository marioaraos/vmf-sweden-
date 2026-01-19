import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'aura_model.dart';

class AuraScreen extends StatefulWidget {
  const AuraScreen({super.key});

  @override
  State<AuraScreen> createState() => _AuraScreenState();
}

class _AuraScreenState extends State<AuraScreen> {
  final PageController _pageController = PageController();
  final ImagePicker _picker = ImagePicker();
  int _currentTab = 2; 

  final List<AuraVideo> _feed = [
    AuraVideo(
      id: "1",
      videoUrl: 'assets/videos/legacy.mp4',
      title: "THE ESSENCE",
      description: "Explorando los pilares fundamentales de nuestra visión global. Un viaje hacia la excelencia y el legado.",
      category: "Inspiración"
    ),
    AuraVideo(
      id: "2",
      videoUrl: 'assets/videos/intro_video.mp4',
      title: "LEGACY PROJECTS",
      description: "Avances de nuestras iniciativas de impacto social y arquitectónico en el mundo.",
      category: "Proyectos"
    ),
  ];

  Future<void> _handleCapture(ImageSource source, {bool isVideo = false}) async {
    if (isVideo) {
      final XFile? video = await _picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes: 1),
      );
      if (video != null) {
        debugPrint("Video capturado: ${video.path}");
      }
    } else {
      final XFile? photo = await _picker.pickImage(source: source);
      if (photo != null) {
        debugPrint("Foto capturada: ${photo.path}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _feed.length,
            itemBuilder: (context, index) {
              return AuraPlayerItem(
                video: _feed[index],
                isLast: index == _feed.length - 1,
              );
            },
          ),
          
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "A U R A",
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 14,
                    letterSpacing: 10,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05), width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (index) {
            if (index == 0) {
              Navigator.pop(context);
              return;
            }
            setState(() => _currentTab = index);
            if (index == 2) {
              _showVMFCreateModal(context);
            }
          },
          backgroundColor: const Color(0xFF0A0A0A),
          selectedItemColor: const Color(0xFFD4AF37),
          unselectedItemColor: Colors.white38,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 28),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded, size: 26), 
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 65, // Aumentado para notoriedad
                height: 65, // Aumentado para notoriedad
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFD4AF37), Color(0xFF8E6E26)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD4AF37).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4), // Margen para el borde dorado
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0A0A0A),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png', 
                        width: 45, // Logo mucho más notorio
                        height: 45, // Logo mucho más notorio
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              label: 'Create',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_rounded, size: 26), 
              label: 'Activity',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 26), 
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _showVMFCreateModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Create",
      barrierColor: Colors.black.withOpacity(0.85),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(anim1),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111111).withOpacity(0.95),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
                          ),
                          child: Center(
                            child: Image.asset('assets/images/logo.png', width: 55),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          "CREAR CONTENIDO",
                          style: GoogleFonts.inter(
                            color: const Color(0xFFD4AF37),
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            letterSpacing: 6,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildVMFOption(
                          icon: Icons.camera_alt_outlined, // Icono Cámara Foto
                          title: "CÁMARA DE FOTOS",
                          subtitle: "Captura y publica un instante",
                          onTap: () => _handleCapture(ImageSource.camera),
                        ),
                        const SizedBox(height: 20),
                        _buildVMFOption(
                          icon: Icons.videocam_outlined, // Icono Cámara Video
                          title: "CÁMARA DE VIDEO",
                          subtitle: "Graba una visión de 60 segundos",
                          onTap: () => _handleCapture(ImageSource.camera, isVideo: true),
                        ),
                        const SizedBox(height: 20),
                        _buildVMFOption(
                          icon: Icons.photo_library_outlined, // Icono Galería
                          title: "GALERÍA DEL CELULAR",
                          subtitle: "Sube contenido de tu biblioteca",
                          onTap: () => _handleCapture(ImageSource.gallery),
                        ),
                        const SizedBox(height: 30),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("CANCELAR", style: GoogleFonts.inter(color: Colors.white24, letterSpacing: 2, fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVMFOption({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFD4AF37), size: 32), // Iconos más grandes
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: GoogleFonts.inter(color: Colors.white38, fontSize: 11)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white.withOpacity(0.1), size: 14),
          ],
        ),
      ),
    );
  }
}

class AuraPlayerItem extends StatefulWidget {
  final AuraVideo video;
  final bool isLast;

  const AuraPlayerItem({super.key, required this.video, required this.isLast});

  @override
  State<AuraPlayerItem> createState() => _AuraPlayerItemState();
}

class _AuraPlayerItemState extends State<AuraPlayerItem> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.video.videoUrl)
      ..initialize().then((_) {
        setState(() => _initialized = true);
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
    return Stack(
      fit: StackFit.expand,
      children: [
        if (_initialized)
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          )
        else
          Container(color: Colors.black),

        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video.title,
                      style: GoogleFonts.playfairDisplay(
                        color: const Color(0xFFD4AF37),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.video.description,
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4)),
                      ),
                      child: Text("SEMBRAR VISIÓN", style: GoogleFonts.inter(color: const Color(0xFFD4AF37), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          right: 15,
          bottom: 120,
          child: Column(
            children: [
              Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                  image: const DecorationImage(image: AssetImage('assets/images/mujer.png'), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 25),
              _buildSideIcon(Icons.favorite_border_rounded, "1.2K"),
              const SizedBox(height: 20),
              _buildSideIcon(Icons.chat_bubble_outline_rounded, "84"),
              const SizedBox(height: 20),
              _buildSideIcon(Icons.bookmark_border_rounded, "450"),
              const SizedBox(height: 20),
              _buildSideIcon(Icons.share_outlined, ""),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black45,
                  border: Border.all(color: Colors.white12),
                ),
                child: const Icon(Icons.music_note_rounded, color: Colors.white70, size: 18),
              ),
            ],
          ),
        ),

        if (!widget.isLast)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(height: 0.5, width: double.infinity, color: const Color(0xFFD4AF37).withOpacity(0.2)),
          ),
      ],
    );
  }

  Widget _buildSideIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.8), size: 28),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(label, style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w500)),
        ]
      ],
    );
  }
}
