import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'dart:math';
import 'package:video_player/video_player.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vmf_lux_project/widgets/luxy_black_modal.dart';
import 'package:vmf_lux_project/widgets/chat_backup_dialog.dart';

class FloatingBubble {
  Offset position;
  Offset velocity;
  double size;
  double rotation = 0;
  double rotationSpeed;
  final String label;
  final String route;
  final int id;
  final bool isLive;
  final int? notifications;
  bool isDragging = false;

  FloatingBubble({
    required this.id,
    required this.position,
    required this.velocity,
    required this.size,
    required this.rotationSpeed,
    required this.label,
    required this.route,
    this.isLive = false,
    this.notifications,
  });
}

class ProfileCreatedScreen extends StatefulWidget {
  final File? userProfileImage;
  const ProfileCreatedScreen({Key? key, this.userProfileImage}) : super(key: key);

  @override
  _ProfileCreatedScreenState createState() => _ProfileCreatedScreenState();
}

class _ProfileCreatedScreenState extends State<ProfileCreatedScreen> with TickerProviderStateMixin {
  late Ticker _ticker;
  final Random _rand = Random();
  late List<FloatingBubble> _bubbles;
  final String _videoAsset = 'assets/videos/legacy.mp4';
  double _time = 0;
  final int _bubbleCount = 10;

  String userName = "ELOHIM GOLD";
  String? userPhotoUrl;
  int seedsBalance = 1250; 
  Offset _parallaxOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();

    final List<Map<String, dynamic>> labels = [
      {'text': 'AURA', 'route': '/aura'}, 
      {'text': 'LIVE', 'route': '/live', 'live': true}, 
      {'text': 'DISCOVER', 'route': '/discover'}, 
      {'text': 'HISTORIA', 'route': '/history'},
      {'text': 'CHAT', 'route': '/chat', 'notif': 3}, 
      {'text': 'OFRENDA', 'route': '/offering'}, 
      {'text': 'VISITORS', 'route': '/visitors'}, 
      {'text': 'MAP', 'route': '/map'}, 
      {'text': 'VERIFY', 'route': '/face_verification'},
      {'text': 'LUX BLACK', 'route': '/lux_black'}, 
    ];

    _bubbles = List.generate(_bubbleCount, (i) {
      return FloatingBubble(
        id: i,
        position: Offset(50.0 + _rand.nextDouble() * 300, 100.0 + _rand.nextDouble() * 500),
        velocity: Offset((_rand.nextDouble() - 0.5) * 1.2, (_rand.nextDouble() - 0.5) * 1.2),
        size: 140, 
        rotationSpeed: (_rand.nextDouble() - 0.5) * 0.01,
        label: labels[i]['text'],
        route: labels[i]['route'],
        isLive: labels[i]['live'] ?? false,
        notifications: labels[i]['notif'],
      );
    });

    _ticker = createTicker(_update)..start();
  }

  Future<void> _loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists && mounted) {
          setState(() {
            userName = doc.data()?['name'] ?? "VMF MEMBER";
            userPhotoUrl = doc.data()?['photoUrl'];
          });
        }
      }
    } catch (e) {
      debugPrint("Error Firebase: $e");
    }
  }

  void _update(Duration elapsed) {
    if (!mounted) return;
    final screenSize = MediaQuery.of(context).size;
    if (screenSize.width == 0) return;
    final double safeHeight = screenSize.height - 100;
    _time += 0.01;
    setState(() {
      for (var b in _bubbles) {
        if (!b.isDragging) {
          b.position += b.velocity;
          b.position += Offset(sin(_time + b.id) * 0.3, cos(_time + b.id) * 0.3);
          
          double radius = b.size / 2;
          if (b.position.dx <= radius) {
            b.position = Offset(radius, b.position.dy);
            b.velocity = Offset(b.velocity.dx.abs(), b.velocity.dy);
          } else if (b.position.dx >= screenSize.width - radius) {
            b.position = Offset(screenSize.width - radius, b.position.dy);
            b.velocity = Offset(-b.velocity.dx.abs(), b.velocity.dy);
          }
          if (b.position.dy <= radius + 60) {
            b.position = Offset(b.position.dx, radius + 60);
            b.velocity = Offset(b.velocity.dx, b.velocity.dy.abs());
          } else if (b.position.dy >= safeHeight - radius) {
            b.position = Offset(b.position.dx, safeHeight - radius);
            b.velocity = Offset(b.velocity.dx, -b.velocity.dy.abs());
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _showMeMenu() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF121212),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.person_outline, color: Color(0xFFD4AF37)),
                title: const Text('View My Profile', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.verified_user_outlined, color: Color(0xFFD4AF37)),
                title: const Text('Identity Verification', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.shield_outlined, color: Color(0xFFD4AF37)),
                title: const Text('Private Mode', style: TextStyle(color: Colors.white)),
                trailing: const Icon(Icons.lock, color: Color(0xFFD4AF37), size: 16),
                onTap: () {
                  Navigator.pop(context);
                  LuxyBlackModal.show(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.storage_rounded, color: Color(0xFFD4AF37)),
                title: const Text('Backup & GDPR', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ChatBackupDialog.show(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.group_add_outlined, color: Color(0xFFD4AF37)),
                title: const Text('Invite Friends', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invitation link copied to clipboard.')));
                },
              ),
              const Divider(color: Colors.white10),
              ListTile(
                leading: const Icon(Icons.help_outline_rounded, color: Colors.white54),
                title: const Text('Support & Help', style: TextStyle(color: Colors.white70)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.description_outlined, color: Colors.white54),
                title: const Text('Terms & Privacy', style: TextStyle(color: Colors.white70)),
                onTap: () {
                  Navigator.pop(context);
                  // Si tienes la ruta /terms configurada en routes.dart descomenta:
                  // Navigator.pushNamed(context, '/terms');
                },
              ),
              const Divider(color: Colors.white10),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text('Log-out', style: TextStyle(color: Colors.redAccent)),
                onTap: () async {
                  Navigator.pop(context);
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, '/intro', (route) => false);
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showMemberCard() {
    HapticFeedback.heavyImpact();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "MemberCard",
      barrierColor: Colors.black.withOpacity(0.95),
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: ScaleTransition(
            scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
            child: FadeTransition(
              opacity: anim1,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 520,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF1A1A1A), Color(0xFF000000), Color(0xFF0A0A0A)],
                    ),
                    border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.4), width: 1.5),
                    boxShadow: [
                      BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.15), blurRadius: 50, spreadRadius: 5),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 45, height: 45,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(image: AssetImage('assets/vmf.png'), fit: BoxFit.contain)
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5)),
                                  ),
                                  child: Text("PLATINUM ELITE", style: GoogleFonts.inter(color: const Color(0xFFD4AF37), letterSpacing: 2, fontSize: 9, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text("VMF SWEDEN", style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 5)),
                            const SizedBox(height: 5),
                            Text("LEGACY PASSPORT", style: GoogleFonts.inter(color: Colors.white24, fontSize: 10, letterSpacing: 3)),
                            const SizedBox(height: 30),
                            Divider(color: Colors.white.withOpacity(0.05)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("SEED BALANCE", style: GoogleFonts.inter(color: const Color(0xFFD4AF37).withOpacity(0.5), fontSize: 8, letterSpacing: 1)),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.workspace_premium_rounded, color: Color(0xFFD4AF37), size: 16),
                                        const SizedBox(width: 8),
                                        Text("$seedsBalance", style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                                  child: const Icon(Icons.qr_code_2_rounded, color: Colors.black, size: 45),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Text(userName.toUpperCase(), style: GoogleFonts.inter(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300, letterSpacing: 2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0D),
      body: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(_parallaxOffset.dx, _parallaxOffset.dy, 0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.5,
                  colors: [Color(0xFF1A1A25), Color(0xFF050505)],
                ),
              ),
            ),
          ),
          InteractiveViewer(
            panEnabled: true,
            scaleEnabled: false,
            boundaryMargin: const EdgeInsets.all(1000),
            onInteractionUpdate: (details) {
              setState(() {
                _parallaxOffset = details.focalPoint * 0.02;
              });
            },
            child: Stack(
              children: _bubbles.map((b) => _buildAnimatedBubble(b)).toList(),
            ),
          ),
          // HEADER ACTIONS
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _showMeMenu,
                  child: Container(
                    width: 45, height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFD4AF37), width: 1),
                      image: _getProfileImage(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.remove_red_eye_outlined, color: Color(0xFFD4AF37), size: 24),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Column(
                children: [
                  const Text("VMF LUX", style: TextStyle(color: Color(0xFFD4AF37), fontSize: 24, letterSpacing: 16, fontWeight: FontWeight.w200)),
                  const SizedBox(height: 8),
                  Text("The Sanctuary", style: TextStyle(color: const Color(0xFFD4AF37).withOpacity(0.35), fontSize: 11, letterSpacing: 6)),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white.withOpacity(0.04), width: 0.5))),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0B0B0D),
          selectedItemColor: const Color(0xFFD4AF37),
          unselectedItemColor: Colors.white12,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            HapticFeedback.mediumImpact();
            if (index == 4) _showMemberCard();
          },
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.blur_on, size: 28), label: ''),
            const BottomNavigationBarItem(icon: Icon(Icons.explore_outlined, size: 24), label: ''),
            const BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline, size: 32), label: ''),
            const BottomNavigationBarItem(icon: Icon(Icons.celebration_outlined, size: 24), label: ''),
            BottomNavigationBarItem(
              icon: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/profile'),
                child: Container(
                  width: 26, height: 26,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.5), width: 1), image: _getProfileImage()),
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  DecorationImage _getProfileImage() {
    if (userPhotoUrl != null && userPhotoUrl!.startsWith('http')) return DecorationImage(image: NetworkImage(userPhotoUrl!), fit: BoxFit.cover);
    else if (widget.userProfileImage != null) return DecorationImage(image: FileImage(widget.userProfileImage!), fit: BoxFit.cover);
    else return const DecorationImage(image: AssetImage('assets/images/hombre.png'), fit: BoxFit.cover);
  }

  Widget _buildAnimatedBubble(FloatingBubble b) {
    return Positioned(
      left: b.position.dx - (b.size / 2),
      top: b.position.dy - (b.size / 2),
      child: GestureDetector(
        onTap: () { 
          HapticFeedback.mediumImpact(); 
          if (b.route == '/lux_black') {
            LuxyBlackModal.show(context);
          }
        },
        onPanStart: (details) {
          setState(() {
            b.isDragging = true;
          });
        },
        onPanUpdate: (details) { 
          HapticFeedback.selectionClick(); 
          setState(() { 
            b.position += details.delta; 
          }); 
        },
        onPanEnd: (details) {
          setState(() {
            b.isDragging = false;
            b.velocity = details.velocity.pixelsPerSecond / 1000;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Bubble3D(videoAsset: _videoAsset, size: b.size, label: b.label),
            if (b.isLive)
              Positioned(
                top: -5, right: 20,
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.6, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, val, child) => Opacity(
                    opacity: val,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
                      child: const Text("LIVE", style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                ),
              ),
            if (b.notifications != null)
              Positioned(
                top: -5, left: 20,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(color: Color(0xFFD4AF37), shape: BoxShape.circle),
                  child: Text("${b.notifications}", style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Bubble3D extends StatefulWidget {
  final String videoAsset;
  final double size;
  final String label;
  const Bubble3D({super.key, required this.videoAsset, required this.size, required this.label});
  @override
  State<Bubble3D> createState() => _Bubble3DState();
}

class _Bubble3DState extends State<Bubble3D> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoAsset)..setLooping(true)..setVolume(0)..initialize().then((_) { _controller.play(); if (mounted) setState(() {}); });
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size, height: widget.size,
      child: ClipPath(
        clipper: _BubbleClipper(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: _controller.value.isInitialized 
                  ? FittedBox(
                      fit: BoxFit.cover, 
                      child: SizedBox(
                        width: _controller.value.size.width, 
                        height: _controller.value.size.height, 
                        child: VideoPlayer(_controller)
                      )
                    ) 
                  : Container(color: Colors.black),
            ),
            CustomPaint(
              painter: _BubblePainter(),
              size: Size(widget.size, widget.size),
            ),
            Positioned(
              bottom: widget.size * 0.2, 
              child: Text(
                widget.label, 
                style: TextStyle(
                  color: const Color(0xFFD4AF37), 
                  letterSpacing: 2, 
                  fontSize: widget.size * 0.11, 
                  fontWeight: FontWeight.w500, 
                  shadows: const [Shadow(color: Colors.black, blurRadius: 4)]
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}

class _BubbleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w * 0.12, h * 0.25);
    path.quadraticBezierTo(w * 0.05, h * 0.50, w * 0.12, h * 0.75);
    path.quadraticBezierTo(w * 0.25, h * 0.95, w * 0.50, h * 0.98);
    path.quadraticBezierTo(w * 0.75, h * 0.95, w * 0.88, h * 0.75);
    path.quadraticBezierTo(w * 0.95, h * 0.50, w * 0.88, h * 0.25);
    path.quadraticBezierTo(w * 0.75, h * 0.05, w * 0.50, h * 0.02);
    path.quadraticBezierTo(w * 0.25, h * 0.05, w * 0.12, h * 0.25);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = _BubbleClipper().getClip(size);

    // Borde fino dorado
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..color = const Color(0xFFD4AF37)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 4);

    // Highlight arriba-izq
    final highlight = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFE08A).withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 8);

    // Glow externo suave
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = const Color(0xFFFFE08A).withOpacity(0.05)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 12);

    canvas.drawPath(path, glow);
    canvas.drawPath(path, border);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.25), size.width * 0.15, highlight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
