import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LuxyChatScreen extends StatefulWidget {
  const LuxyChatScreen({super.key});

  @override
  State<LuxyChatScreen> createState() => _LuxyChatScreenState();
}

class _LuxyChatScreenState extends State<LuxyChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    try {
      if (_auth.currentUser == null) {
        await _auth.signInAnonymously();
      }
    } catch (e) {
      debugPrint("Error Auth: $e");
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Iniciando sesión... reintente en un segundo")));
      await _checkAuth();
      return;
    }

    final String text = _messageController.text.trim();
    _messageController.clear();

    try {
      await _firestore.collection('chats').add({
        'text': text,
        'senderId': user.uid,
        'senderName': user.displayName ?? "VMF Member",
        'createdAt': FieldValue.serverTimestamp(),
        'isAdmin': false,
      });
    } catch (e) {
      debugPrint("Error Firestore: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: Verifica las reglas de Firestore")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "CONCIERGE",
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            fontSize: 14,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFFD4AF37), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chats')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("Error de conexión: ${snapshot.error}", 
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
                  ));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    bool isMe = data['senderId'] == _auth.currentUser?.uid;
                    return LuxyChatMessage(
                      sender: data['senderName'] ?? "Unknown",
                      text: data['text'] ?? "",
                      isMe: isMe,
                      isAdmin: data['isAdmin'] ?? false,
                    );
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            border: const Border(top: BorderSide(color: Colors.white10, width: 0.5)),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: GoogleFonts.inter(color: const Color(0xFFE1E1E1), fontSize: 14),
                    decoration: InputDecoration(
                      hintText: "Escriba su mensaje...",
                      hintStyle: GoogleFonts.inter(color: Colors.white24, fontSize: 14),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send_rounded, color: Color(0xFFD4AF37), size: 22),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LuxyChatMessage extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final bool isAdmin;

  const LuxyChatMessage({
    super.key,
    required this.sender,
    required this.text,
    required this.isMe,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe) _buildAvatar(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isMe)
                          Container(
                            width: 1.5,
                            height: 10,
                            margin: const EdgeInsets.only(right: 8),
                            color: const Color(0xFFD4AF37),
                          ),
                        Text(
                          sender.toUpperCase(),
                          style: GoogleFonts.playfairDisplay(
                            color: isAdmin ? const Color(0xFFD4AF37) : const Color(0xFFE1E1E1).withOpacity(0.5),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      text,
                      textAlign: isMe ? TextAlign.right : TextAlign.left,
                      style: GoogleFonts.inter(
                        color: const Color(0xFFE1E1E1),
                        fontSize: 14,
                        height: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMe) ...[
                const SizedBox(width: 12),
                _buildAvatar(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE1E1E1).withOpacity(0.1), width: 1),
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: Image.asset(
          isMe ? 'assets/images/hombre.png' : 'assets/images/logo.png',
          width: 20,
          height: 20,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
