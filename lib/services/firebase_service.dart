import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // --- AUTHENTICATION ---

  // Stream to listen to auth state changes
  Stream<User?> get userState => _auth.authStateChanges();

  // Sign in anonymously (for quick start)
  Future<UserCredential?> signInAnonymously() async {
    try {
      return await _auth.signInAnonymously();
    } catch (e) {
      print("Auth Error: $e");
      return null;
    }
  }

  // Sign in with Email/Password
  Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // Register with Email/Password
  Future<UserCredential?> registerWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print("Registration Error: $e");
      return null;
    }
  }

  // --- FIRESTORE (User Data) ---

  Future<void> saveUserData({
    required String uid,
    required String name,
    String? photoUrl,
    String? gender,
    String? birthday,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'photoUrl': photoUrl,
      'gender': gender,
      'birthday': birthday,
      'status': 'active',
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // --- STORAGE (Profile Photos) ---

  Future<String?> uploadProfilePhoto(String uid, File imageFile) async {
    try {
      final ref = _storage.ref().child('profile_photos').child('$uid.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print("Upload Error: $e");
      return null;
    }
  }
}
