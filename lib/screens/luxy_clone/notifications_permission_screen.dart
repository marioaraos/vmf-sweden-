import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'widgets/custom_button.dart';

class NotificationsPermissionScreen extends StatefulWidget {
  const NotificationsPermissionScreen({Key? key}) : super(key: key);

  @override
  _NotificationsPermissionScreenState createState() => _NotificationsPermissionScreenState();
}

class _NotificationsPermissionScreenState extends State<NotificationsPermissionScreen> {
  bool newMessages = true;
  bool alertSound = false;
  bool vibrate = false;
  final Color neonBlue = const Color(0xFF00E5FF);
  final Color luxyGold = const Color(0xFFD4AF37);

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
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Row(
                    children: List.generate(5, (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == 4 ? Colors.white : Colors.grey[900],
                      ),
                    )),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.monetization_on, color: luxyGold, size: 16),
                        const SizedBox(width: 5),
                        const Text("15", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Mantente informado!',
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Activa las notificaciones para no perderte nunca un mensaje o un match importante.',
                    style: TextStyle(color: Colors.white54, fontSize: 15, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildNotificationTile("Nuevos mensajes", newMessages, (val) => setState(() => newMessages = val)),
                  const SizedBox(height: 15),
                  _buildNotificationTile("Sonido de alerta", alertSound, (val) => setState(() => alertSound = val)),
                  const SizedBox(height: 15),
                  _buildNotificationTile("Vibración", vibrate, (val) => setState(() => vibrate = val)),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  const Text(
                    'Completa para ganar 20 Monedas',
                    style: TextStyle(color: Colors.white30, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  LuxyButton(
                    text: "Siguiente",
                    isActive: true,
                    onPressed: () => Navigator.pushNamed(context, '/photos_single'),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationTile(String title, bool value, Function(bool) onChanged) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: luxyGold.withOpacity(0.4), width: 0.8),
        boxShadow: [if (value) BoxShadow(color: luxyGold.withOpacity(0.1), blurRadius: 10, spreadRadius: 1)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5)),
          CupertinoSwitch(activeColor: neonBlue, trackColor: Colors.grey[900], value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
