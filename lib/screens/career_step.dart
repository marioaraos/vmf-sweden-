// 💰 CAREER STEP – INCOME SELECTOR CON ESTILO LUXY
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vmf_lux_project/config/palette.dart'; //

class CareerStep extends StatefulWidget {
  const CareerStep({Key? key}) : super(key: key);

  @override
  State<CareerStep> createState() => _CareerStepState();
}

class _CareerStepState extends State<CareerStep> {
  double _currentIncome = 50000;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Annual Income",
            style: GoogleFonts.playfairDisplay(color: LuxyPalette.white, fontSize: 24)),
        const SizedBox(height: 30),

        // Indicador de Ingresos
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: LuxyPalette.gold500),
            ),
            child: Text(
              "\$${_currentIncome.toInt()} USD",
              style: TextStyle(color: LuxyPalette.gold500, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 40),

        // Slider con Gradiente Dorado
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: LuxyPalette.gold700,
            inactiveTrackColor: LuxyPalette.grey800,
            thumbColor: LuxyPalette.gold500,
            overlayColor: LuxyPalette.gold500.withOpacity(0.2),
          ),
          child: Slider(
            min: 20000,
            max: 1000000,
            value: _currentIncome,
            onChanged: (value) => setState(() => _currentIncome = value),
          ),
        ),

        // Badge "M" Dorado si supera los 200k
        if (_currentIncome >= 200000)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified, color: LuxyPalette.gold500, size: 20),
                const SizedBox(width: 8),
                Text("Eligible for Millionaire Badge",
                    style: TextStyle(color: LuxyPalette.gold500, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
      ],
    );
  }
}