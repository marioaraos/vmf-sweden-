import 'dart:ui';
import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({Key? key}) : super(key: key);

  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;
  final Color neonBlue = const Color(0xFF00E5FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  Row(
                    children: List.generate(5, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 0 ? Colors.white : Colors.grey[900],
                      ),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.monetization_on, color: Color(0xFFD4AF37), size: 16),
                        SizedBox(width: 5),
                        Text("0", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecciona tu Género',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Por favor elige tu género para\npersonalizar tus sugerencias.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.4),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildGenderOption(
                        gender: 'Hombre',
                        imagePath: 'assets/images/hombre.png',
                        isSelected: selectedGender == 'Hombre',
                      ),
                    ),
                    Expanded(
                      child: _buildGenderOption(
                        gender: 'Mujer',
                        imagePath: 'assets/images/mujer.png',
                        isSelected: selectedGender == 'Mujer',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
              child: Column(
                children: [
                  const Text(
                    'Completa para ganar 5 Monedas',
                    style: TextStyle(color: Colors.white30, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  LuxyButton(
                    text: "Siguiente",
                    isActive: selectedGender != null,
                    onPressed: () => Navigator.pushNamed(context, '/name'),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      '¿Ya tienes una cuenta? Iniciar Sesión',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderOption({
    required String gender,
    required String imagePath,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isSelected)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 12 * value, sigmaY: 12 * value),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                      color: neonBlue.withOpacity(0.8),
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 400),
              scale: isSelected ? 1.02 : 0.95,
              curve: Curves.easeOut,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isSelected
                      ? [Colors.black, Colors.black87]
                      : [Colors.white10, Colors.black],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.person, size: 200, color: Colors.white10
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? neonBlue : Colors.white24,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 3,
                fontSize: 14,
                shadows: isSelected ? [
                  Shadow(color: neonBlue.withOpacity(0.8), blurRadius: 10)
                ] : [],
              ),
              child: Text(gender.toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }
}
