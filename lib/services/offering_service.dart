import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OfferingService {
  OfferingService._();
  static final instance = OfferingService._();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  /// Guarda una ofrenda / apoyo VMF en Firestore
  Future<void> saveOffering({
    required String productId,
    required String productTitle,
    required String price,
    required bool isSubscription,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      // Si por alguna razón no hay usuario, usamos el anónimo o fallamos
      return;
    }

    try {
      await _firestore.collection('offerings').add({
        'uid': user.uid,
        'email': user.email,
        'product_id': productId,
        'product_title': productTitle,
        'price': price,
        'subscription': isSubscription,
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'created_at': FieldValue.serverTimestamp(),
        'status': 'completed',
        'source': 'in_app_purchase',
      });
    } catch (e) {
      print("Error guardando ofrenda en Firestore: $e");
    }
  }
}
