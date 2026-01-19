import 'package:flutter/material.dart';
import 'dart:ui';
import '../config/palette.dart';
import 'discovery_page.dart';
import 'likes_page.dart';
import 'qr_pass_page.dart';
import '../screens/profile_screen.dart';
import '../screens/messages_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({Key? key}) : super(key: key);
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DiscoveryPage(),
    const LikesPage(),
    const MessagesScreen(),
    const QrPassPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Permite que el contenido se vea bajo la barra glass
      body: _pages[_selectedIndex],
      bottomNavigationBar: _buildBubbleBar(),
    );
  }

  Widget _buildBubbleBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      height: 70,
      decoration: BoxDecoration(
        color: LuxyPalette.grey900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: LuxyPalette.gold500.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _navItem(0, Icons.diamond_outlined),
              _navItem(1, Icons.favorite_border),
              _navItem(2, Icons.chat_bubble_outline),
              _navItem(3, Icons.wine_bar),
              _navItem(4, Icons.person_outline),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? LuxyPalette.gold500.withOpacity(0.1) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isSelected ? LuxyPalette.gold500 : LuxyPalette.grey600,
          size: isSelected ? 30 : 26,
        ),
      ),
    );
  }
}