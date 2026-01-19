import 'package:flutter/material.dart';
import 'dart:math';

class SuperLikeParticles extends StatefulWidget {
  final bool active;
  const SuperLikeParticles({Key? key, required this.active}) : super(key: key);

  @override
  _SuperLikeParticlesState createState() => _SuperLikeParticlesState();
}

class _SuperLikeParticlesState extends State<SuperLikeParticles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _rand = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    if (widget.active) {
      _generateParticles();
      _controller.repeat();
    }
  }

  void _generateParticles() {
    for (int i = 0; i < 30; i++) {
      _particles.add(Particle(
        angle: _rand.nextDouble() * 2 * pi,
        speed: 2 + _rand.nextDouble() * 4,
        size: 2 + _rand.nextDouble() * 4,
        opacity: 0.5 + _rand.nextDouble() * 0.5,
      ));
    }
  }

  @override
  void didUpdateWidget(SuperLikeParticles oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !oldWidget.active) {
      _particles.clear();
      _generateParticles();
      _controller.repeat();
    } else if (!widget.active) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.active) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(_particles, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  final double angle;
  final double speed;
  final double size;
  final double opacity;

  Particle({required this.angle, required this.speed, required this.size, required this.opacity});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double progress;

  ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..color = const Color(0xFFD4AF37);

    for (var p in particles) {
      final distance = progress * 200 * p.speed;
      final offset = Offset(
        center.dx + cos(p.angle) * distance,
        center.dy + sin(p.angle) * distance,
      );
      
      paint.opacity = (1.0 - progress) * p.opacity;
      canvas.drawCircle(offset, p.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
