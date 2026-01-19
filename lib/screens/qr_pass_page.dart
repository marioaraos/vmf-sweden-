// 🎟️ QR PASS – ENTRADA EXCLUSIVA A EVENTOS
import 'package:flutter/material.dart';
import 'package:vmf_lux_project/config/palette.dart'; //

class QrPassPage extends StatelessWidget {
  const QrPassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LuxyPalette.black,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Center(
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: LuxyPalette.grey900.withOpacity(0.8),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: LuxyPalette.gold500.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("GALA DINNER 2026",
                  style: TextStyle(color: LuxyPalette.gold500, letterSpacing: 4, fontWeight: FontWeight.w200, fontSize: 18)),
              const SizedBox(height: 30),

              // Simulación de QR (Puedes usar la librería qr_flutter)
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: LuxyPalette.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: LuxyPalette.gold500, width: 4),
                ),
                child: const Icon(Icons.qr_code_2, size: 150, color: Colors.black),
              ),

              const SizedBox(height: 30),
              Text("Verified Guest", style: TextStyle(color: LuxyPalette.grey600)),
              Text("VMF MEMBER", style: TextStyle(color: LuxyPalette.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}