import 'package:flutter/material.dart';
import 'package:vmf_lux_project/screens/discover_screen.dart';
import 'package:vmf_lux_project/screens/messages_screen.dart';
import 'package:vmf_lux_project/screens/community_screen.dart';
import 'package:vmf_lux_project/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const Color primaryGold = Color(0xFFD4AF37);
  static const Color surfaceBlack = Colors.black;
  static const Color cardGrey = Color(0xFF1A1A1A);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceBlack,
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          _DashboardTab(),
          DiscoverScreen(),
          MessagesScreen(),
          CommunityScreen(),
          ProfilePage(isTab: true),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: surfaceBlack,
        selectedItemColor: primaryGold,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Mensajes'),
          BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: 'Comunidad'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryGold = Color(0xFFD4AF37);
    const Color surfaceBlack = Colors.black;
    const Color cardGrey = Color(0xFF1A1A1A);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: surfaceBlack,
          floating: true,
          centerTitle: true,
          title: const Text(
            'LUXY',
            style: TextStyle(
              color: primaryGold,
              letterSpacing: 4,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none, color: primaryGold),
              onPressed: () {},
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bubble Menu - 11 Bubbles
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  children: [
                    _buildBubbleMenu(context, 'Eventos', Icons.event, '/events', primaryGold),
                    _buildBubbleMenu(context, 'Galería', Icons.photo_library, '/discover', primaryGold),
                    _buildBubbleMenu(context, 'Mapa', Icons.map_outlined, '/map', primaryGold),
                    _buildBubbleMenu(context, 'Aura', Icons.auto_awesome, '/aura', primaryGold),
                    _buildBubbleMenu(context, 'VMF TV', Icons.live_tv, '/live', primaryGold),
                    _buildBubbleMenu(context, 'Ofrendas', Icons.volunteer_activism, '/offering', primaryGold),
                    _buildBubbleMenu(context, 'Historia', Icons.history_edu, '/history', primaryGold),
                    _buildBubbleMenu(context, 'Luxy Chat', Icons.forum_outlined, '/chat', primaryGold),
                    _buildBubbleMenu(context, 'Visitantes', Icons.people_outline, '/visitors', primaryGold),
                    _buildBubbleMenu(context, 'Santuario', Icons.account_balance, '/sanctuary', primaryGold),
                    _buildBubbleMenu(context, 'Verificar', Icons.verified_user_outlined, '/face_verification', primaryGold),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Bienvenido, Luxer',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildFeaturedCard(cardGrey, primaryGold),
                    const SizedBox(height: 30),
                    const Text(
                      'Recomendados para ti',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    _buildHorizontalList(cardGrey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBubbleMenu(BuildContext context, String label, IconData icon, String route, Color gold) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: gold.withOpacity(0.5), width: 1.5),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [gold.withOpacity(0.2), Colors.transparent],
                ),
              ),
              child: Icon(icon, color: gold, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w300),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCard(Color cardGrey, Color primaryGold) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: cardGrey,
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1566073771259-6a8506099945?q=80&w=1000&auto=format&fit=crop'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Experiencia Exclusive',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Reserva ahora el mejor spot',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Ver Detalles'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(Color cardGrey) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: cardGrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: const Center(child: Icon(Icons.image, color: Colors.white24)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Lugar Lux',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
