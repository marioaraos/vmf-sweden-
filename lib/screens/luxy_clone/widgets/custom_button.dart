import 'package:flutter/material.dart';

class LuxyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isActive;

  const LuxyButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color neonBlue = Color(0xFF00E5FF);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: isActive ? neonBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isActive ? neonBlue : Colors.grey[800]!,
          width: 2,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: neonBlue.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: neonBlue.withOpacity(0.4),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isActive ? onPressed : null,
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isActive ? Colors.black : Colors.grey[700],
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
              child: Text(text.toUpperCase()),
            ),
          ),
        ),
      ),
    );
  }
}
