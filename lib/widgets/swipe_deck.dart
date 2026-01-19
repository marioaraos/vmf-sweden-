import 'package:flutter/material.dart';
import '../config/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class SwipeDeck extends StatefulWidget {
  const SwipeDeck({Key? key}) : super(key: key);

  @override
  State<SwipeDeck> createState() => _SwipeDeckState();
}

class _SwipeDeckState extends State<SwipeDeck> {
  // Datos de prueba con tus assets
  final List<Map<String, dynamic>> _users = [
    {'name': 'Ana', 'age': 28, 'city': 'Stockholm', 'image': 'assets/images/mujer.png'},
    {'name': 'Erik', 'age': 31, 'city': 'Gothenburg', 'image': 'assets/images/hombre.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: _users.asMap().entries.map((entry) {
          int index = entry.key;
          var user = entry.value;
          return _buildCard(user, index);
        }).toList(),
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> user, int index) {
    return Draggable(
      feedback: _cardContent(user, isFeedback: true),
      childWhenDragging: Container(),
      onDragEnd: (details) {
        if (details.offset.dx > 100 || details.offset.dx < -100) {
          setState(() => _users.removeAt(index));
        }
      },
      child: _cardContent(user),
    );
  }

  Widget _cardContent(Map<String, dynamic> user, {bool isFeedback = false}) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 320,
        height: 440,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: LuxyPalette.gold500, width: 0.5),
          image: DecorationImage(image: AssetImage(user['image']), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LuxyPalette.blackFade,
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${user['name']}, ${user['age']}",
                  style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(user['city'], style: GoogleFonts.inter(color: LuxyPalette.grey200, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}