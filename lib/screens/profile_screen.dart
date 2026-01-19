// 👤 PROFILE – LUXY STYLE
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vmf_lux_project/config/palette.dart';

class ProfilePage extends StatefulWidget {
  final bool isTab;
  const ProfilePage({Key? key, this.isTab = false}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Loading...";
  String userEmail = "...";
  String? userPhotoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userEmail = user.email ?? "";
        });
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists && mounted) {
          setState(() {
            userName = doc.data()?['name'] ?? "VMF MEMBER";
            userPhotoUrl = doc.data()?['photoUrl'];
          });
        }
      }
    } catch (e) {
      debugPrint("Error loading profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFD4AF37);
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text('PROFILE', style: TextStyle(color: goldColor, letterSpacing: 2, fontWeight: FontWeight.w300)),
        centerTitle: true,
        automaticallyImplyLeading: !widget.isTab,
        leading: widget.isTab 
          ? null 
          : IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: goldColor, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            _avatar(goldColor),
            const SizedBox(height: 16),
            _nameEmail(),
            const SizedBox(height: 40),
            _sectionTitle('My Data'),
            _dataCard('Name', userName, goldColor),
            _dataCard('Email', userEmail, goldColor),
            const Spacer(),
            _logoutButton(context, goldColor),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _avatar(Color goldColor) => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: goldColor.withOpacity(0.5), width: 1),
        ),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: goldColor.withOpacity(0.1),
          backgroundImage: (userPhotoUrl != null && userPhotoUrl!.isNotEmpty) 
              ? NetworkImage(userPhotoUrl!) 
              : const AssetImage('assets/images/hombre.png') as ImageProvider,
          child: (userPhotoUrl == null || userPhotoUrl!.isEmpty)
              ? Icon(Icons.person, color: goldColor.withOpacity(0.5), size: 50)
              : null,
        ),
      );

  Widget _nameEmail() => Column(
        children: [
          Text(userName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300)),
          const SizedBox(height: 4),
          Text(userEmail,
              style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 14)),
        ],
      );

  Widget _sectionTitle(String title) => Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
                fontWeight: FontWeight.w500)),
      );

  Widget _dataCard(String label, String value, Color goldColor) => Container(
        margin: const EdgeInsets.only(top: 12),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: goldColor.withOpacity(0.3), width: 1),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              goldColor.withOpacity(0.07),
              goldColor.withOpacity(0.02),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300)),
          ],
        ),
      );

  Widget _logoutButton(BuildContext context, Color goldColor) => SizedBox(
        width: double.infinity,
        height: 55,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: goldColor.withOpacity(0.5)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
          child: const Text('LOG OUT', style: TextStyle(color: Colors.white, letterSpacing: 2)),
        ),
      );
}
