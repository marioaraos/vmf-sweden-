import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'MENSAJES',
          style: GoogleFonts.inter(
            color: goldColor,
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: goldColor,
          labelColor: goldColor,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'SOLICITUDES'),
            Tab(text: 'NOTIF.'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatList(),
          _buildRequestsList(),
          _buildNotificationsList(),
        ],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.separated(
      itemCount: 5,
      separatorBuilder: (context, index) => const Divider(color: Colors.white10),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white10,
            child: Icon(Icons.person, color: Colors.white54),
          ),
          title: Text('Luxer ${index + 1}', style: const TextStyle(color: Colors.white)),
          subtitle: const Text('Último mensaje enviado...', style: TextStyle(color: Colors.grey, fontSize: 12)),
          trailing: const Text('12:45', style: TextStyle(color: Colors.grey, fontSize: 10)),
          onTap: () => Navigator.pushNamed(context, '/chat'),
        );
      },
    );
  }

  Widget _buildRequestsList() {
    return const Center(
      child: Text('No tienes solicitudes nuevas', style: TextStyle(color: Colors.white70)),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.star, color: Color(0xFFD4AF37)),
          title: const Text('Nuevo Match', style: TextStyle(color: Colors.white)),
          subtitle: const Text('¡Tienes un nuevo match! Empieza a chatear.', style: TextStyle(color: Colors.grey, fontSize: 12)),
          trailing: const Text('Hoy', style: TextStyle(color: Colors.grey, fontSize: 10)),
        );
      },
    );
  }
}
