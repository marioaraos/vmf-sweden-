import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class IAPService {
  IAPService._internal();
  static final IAPService instance = IAPService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;

  // IDs definidos para VMF LUX
  static const Set<String> _productIds = {
    'vmf_support_basic',
    'vmf_support_premium',
    'vmf_support_elite',
  };

  final StreamController<PurchaseStatus> _purchaseStatusController = StreamController<PurchaseStatus>.broadcast();
  Stream<PurchaseStatus> get purchaseStatusStream => _purchaseStatusController.stream;

  void initialize() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _iap.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _handlePurchaseUpdates(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      debugPrint("IAP Subscription Error: $error");
    });
    
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final bool available = await _iap.isAvailable();
    if (!available) return;

    final ProductDetailsResponse response = await _iap.queryProductDetails(_productIds);
    if (response.notFoundIDs.isNotEmpty) {
      debugPrint("Products not found: ${response.notFoundIDs}");
    }
    
    _products = response.productDetails;
    _products.sort((a, b) => a.rawPrice.compareTo(b.rawPrice));
  }

  void buy(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    // Para consumibles (ofrendas)
    _iap.buyConsumable(purchaseParam: purchaseParam);
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchaseDetailsList) async {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        _purchaseStatusController.add(PurchaseStatus.pending);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        _purchaseStatusController.add(PurchaseStatus.error);
      } else if (purchaseDetails.status == PurchaseStatus.purchased ||
                 purchaseDetails.status == PurchaseStatus.restored) {
        
        // Aquí es donde validamos la compra
        bool valid = await _verifyPurchase(purchaseDetails);
        if (valid) {
          _purchaseStatusController.add(PurchaseStatus.purchased);
        }
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await _iap.completePurchase(purchaseDetails);
      }
    }
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchase) async {
    return true; 
  }

  void dispose() {
    _subscription.cancel();
    _purchaseStatusController.close();
  }
}
