import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../services/payment_service.dart';
import 'thank_you_screen.dart';

class OfferingScreen extends StatefulWidget {
  const OfferingScreen({super.key});

  @override
  State<OfferingScreen> createState() => _OfferingScreenState();
}

class _OfferingScreenState extends State<OfferingScreen> {
  final PaymentService _paymentService = PaymentService.instance;

  @override
  void initState() {
    super.initState();
    // Escuchamos el estado de compra para navegar a Gracias
    _paymentService.isPurchasing.addListener(_handlePurchaseSuccess);
  }

  @override
  void dispose() {
    _paymentService.isPurchasing.removeListener(_handlePurchaseSuccess);
    super.dispose();
  }

  void _handlePurchaseSuccess() {
    if (!_paymentService.isPurchasing.value && _paymentService.products.value.isNotEmpty) {
      // Si ya no está comprando y fue un éxito (puedes añadir lógica de validación extra aquí)
      // Por ahora simulamos que si termina el estado de compra fue exitoso para mostrar la UI Lux
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
          "SEMBRAR SEMILLAS",
          style: GoogleFonts.inter(
            color: const Color(0xFFD4AF37),
            fontSize: 14,
            letterSpacing: 4,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withOpacity(0.05),
                    blurRadius: 150,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          
          ValueListenableBuilder<bool>(
            valueListenable: _paymentService.isPurchasing,
            builder: (context, isPurchasing, child) {
              if (isPurchasing) {
                return const Center(child: CircularProgressIndicator(color: Color(0xFFD4AF37)));
              }
              return child!;
            },
            child: Column(
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Tu contribución fortalece el legado global de VMF Sweden.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                
                Expanded(
                  child: ValueListenableBuilder<List<ProductDetails>>(
                    valueListenable: _paymentService.products,
                    builder: (context, products, _) {
                      if (products.isEmpty) {
                        return Center(
                          child: Text("Conectando con la tienda...", 
                            style: GoogleFonts.inter(color: Colors.white24, fontSize: 12))
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return _buildOfferingCard(context, product);
                        },
                      );
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: TextButton(
                    onPressed: () => _paymentService.restorePurchases(),
                    child: Text("RESTAURAR APOYO", 
                      style: GoogleFonts.inter(color: Colors.white24, fontSize: 10, letterSpacing: 2)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferingCard(BuildContext context, ProductDetails product) {
    Color accentColor;
    if (product.id.contains('basic')) accentColor = const Color(0xFFCD7F32);
    else if (product.id.contains('premium')) accentColor = const Color(0xFFC0C0C0);
    else accentColor = const Color(0xFFD4AF37);

    return GestureDetector(
      onTap: () => _paymentService.buy(product),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accentColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: accentColor.withOpacity(0.1),
                    ),
                    child: Icon(Icons.workspace_premium_rounded, color: accentColor, size: 30),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title.toUpperCase(),
                          style: GoogleFonts.inter(
                            color: accentColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.description,
                          style: GoogleFonts.inter(color: Colors.white54, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product.price,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
