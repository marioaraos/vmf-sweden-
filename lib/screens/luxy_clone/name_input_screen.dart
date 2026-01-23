import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({Key? key}) : super(key: key);

  @override
  _NameInputScreenState createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool isButtonEnabled = false;
  final Color neonBlue = const Color(0xFF00E5FF);

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkName);
  }

  void _checkName() {
    setState(() {
      isButtonEnabled = _nameController.text.trim().length >= 2;
    });
  }

  Future<void> _saveNameAndContinue() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        final credential = await FirebaseAuth.instance.signInAnonymously();
        user = credential.user;
      }

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'lastUpdated': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));

        if (mounted) {
          Navigator.pushNamed(context, '/birthday');
        }
      }
    } catch (e) {
      debugPrint("Error guardando nombre: $e");
      if (mounted) {
        Navigator.pushNamed(context, '/birthday');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
                        color: index == 1 ? Colors.white : Colors.grey[900],
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
                        Text("5", style: TextStyle(color: Colors.white, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              '¿Cómo te llamas?',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tu nombre aparecerá en tu perfil.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 15),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    if (_nameController.text.isNotEmpty)
                      BoxShadow(color: neonBlue.withOpacity(0.1), blurRadius: 20, spreadRadius: 1),
                  ],
                ),
                child: TextField(
                  controller: _nameController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 1),
                  textCapitalization: TextCapitalization.words,
                  textAlign: TextAlign.center,
                  cursorColor: neonBlue,
                  decoration: InputDecoration(
                    hintText: 'Introduce tu nombre',
                    hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.03),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey[900]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: neonBlue.withOpacity(0.5), width: 1.5),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                children: [
                  const Text(
                    'Completa para ganar 10 Monedas',
                    style: TextStyle(color: Colors.white30, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  LuxyButton(
                    text: "Siguiente",
                    isActive: isButtonEnabled,
                    onPressed: _saveNameAndContinue,
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
}
