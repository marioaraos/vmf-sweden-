import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'EXCLUSIVE EVENTS',
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildEventCard(
            'Black-tie Party',
            'The Ritz, Madrid',
            'Oct 24, 2024 • 21:00',
            'https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?q=80&w=1000&auto=format&fit=crop',
            isUpcoming: true,
          ),
          const SizedBox(height: 20),
          _buildEventCard(
            'Yacht Networking',
            'Puerto Banús, Marbella',
            'Nov 12, 2024 • 14:00',
            'https://images.unsplash.com/photo-1544427928-142ec2473859?q=80&w=1000&auto=format&fit=crop',
          ),
          const SizedBox(height: 20),
          _buildEventCard(
            'Luxury Polo Cup',
            'Sotogrande',
            'Dec 05, 2024 • 11:00',
            'https://images.unsplash.com/photo-1528605248644-14dd04022da1?q=80&w=1000&auto=format&fit=crop',
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String location, String date, String imageUrl, {bool isUpcoming = false}) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          if (isUpcoming)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'PUSH SENT',
                  style: GoogleFonts.inter(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.9)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFD4AF37), size: 14),
                      const SizedBox(width: 5),
                      Text(location, style: GoogleFonts.inter(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Color(0xFFD4AF37), size: 14),
                      const SizedBox(width: 5),
                      Text(date, style: GoogleFonts.inter(color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
