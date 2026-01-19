import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginOptionsScreen extends StatelessWidget {
  const LoginOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Negro profundo Luxy
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'VMF SWEDEN',
              style: GoogleFonts.playfairDisplay(
                color: const Color(0xFFD4AF37), // Oro
                fontSize: 32,
                letterSpacing: 8,
              ),
            ),
            const SizedBox(height: 60),
            _loginButton(context, 'Continue with Email', '/login'),
            const SizedBox(height: 20),
            Text(
              'By continuing you agree to our Terms',
              style: GoogleFonts.inter(color: const Color(0xFFE1E1E1), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context, String text, String route) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFD4AF37)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: GoogleFonts.inter(color: Colors.white)),
      ),
    );
  }
}// Pantalla de selección de método de inicio de sesión
