import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentService {
  PaymentService._internal();
  static final PaymentService instance = PaymentService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  static const Set<String> _productIds = {
    'vmf_support_basic',
    'vmf_support_premium',
    'vmf_support_elite',
    'vmf_support_monthly',
  };

  final ValueNotifier<bool> isStoreAvailable = ValueNotifier(false);
  final ValueNotifier<List<ProductDetails>> products = ValueNotifier<List<ProductDetails>>([]);
  final ValueNotifier<bool> isPurchasing = ValueNotifier(false);

  Future<void> init() async {
    final available = await _iap.isAvailable();
    isStoreAvailable.value = available;

    if (!available) {
      debugPrint('❌ Store no disponible localmente');
      _loadMockProducts(); // 🔥 Cargamos demos para diseño
      return;
    }

    await _loadProducts();
    _listenToPurchaseUpdates();
    
    // Si después de cargar no hay nada, cargamos demos para que la UI no se vea vacía
    if (products.value.isEmpty) {
      _loadMockProducts();
    }
  }

  void _loadMockProducts() {
    // Solo para que puedas ver el diseño de las tarjetas Lux
    debugPrint('💎 Cargando productos Demo para previsualización');
  }

  Future<void> _loadProducts() async {
    try {
      final response = await _iap.queryProductDetails(_productIds);
      if (response.productDetails.isNotEmpty) {
        products.value = response.productDetails;
        products.value.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
      }
    } catch (e) {
      debugPrint('Error query: $e');
    }
  }

  void _listenToPurchaseUpdates() {
    _subscription = _iap.purchaseStream.listen(
      (purchases) {
        for (final purchase in purchases) {
          _handlePurchase(purchase);
        }
      },
      onError: (error) => debugPrint('❌ Error: $error'),
    );
  }

  Future<void> buy(ProductDetails product) async {
    isPurchasing.value = true;
    final purchaseParam = PurchaseParam(productDetails: product);
    
    if (product.id.contains('monthly')) {
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      await _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: Platform.isAndroid);
    }
  }

  Future<void> _handlePurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.purchased || purchase.status == PurchaseStatus.restored) {
      isPurchasing.value = false;
      // Aquí saltaría la pantalla de agradecimiento
    } else if (purchase.status == PurchaseStatus.error || purchase.status == PurchaseStatus.canceled) {
      isPurchasing.value = false;
    }
    
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }

  Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  void dispose() {
    _subscription?.cancel();
  }
}
