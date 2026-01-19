import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/palette.dart';

class CareerStep extends StatefulWidget {
  const CareerStep({Key? key}) : super(key: key);

  @override
  State<CareerStep> createState() => _CareerStepState();
}

class _CareerStepState extends State<CareerStep> {
  double _income = 150000;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: LuxyPalette.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Annual Income", style: GoogleFonts.playfairDisplay(color: LuxyPalette.white, fontSize: 26)),
          const SizedBox(height: 40),
          Text("\$${_income.toInt()} USD",
              style: GoogleFonts.inter(color: LuxyPalette.gold500, fontSize: 32, fontWeight: FontWeight.w200)),
          Slider(
            value: _income,
            min: 50000, max: 1000000,
            activeColor: LuxyPalette.gold500,
            inactiveColor: LuxyPalette.grey800,
            onChanged: (val) => setState(() => _income = val),
          ),
          if (_income >= 200000) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.stars, color: LuxyPalette.gold500),
                const SizedBox(width: 8),
                Text("GOLDEN M ELITE STATUS", style: TextStyle(color: LuxyPalette.gold500, letterSpacing: 2)),
              ],
            )
          ]
        ],
      ),
    );
  }
}