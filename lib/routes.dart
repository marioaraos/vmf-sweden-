import 'package:flutter/material.dart';
// Importaciones de tus pantallas existentes
import 'screens/splash_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/login_options_screen.dart';
import 'screens/registration/name_input_screen.dart';
import 'screens/registration/birthday_input_screen.dart';
import 'screens/registration/gender_selection_screen.dart';
import 'screens/registration/photo_upload_screen.dart';
import 'screens/home_screen.dart';

// Importaciones de las nuevas pantallas Luxy (ajusta la ruta según donde las creaste)
import 'ui/discovery_page.dart';
import 'ui/likes_page.dart';
import 'ui/qr_pass_page.dart';
import 'ui/career_step.dart';

class AppRoutes {
  static const String splash = '/';
  static const String loginOptions = '/login_options';
  static const String login = '/login';
  static const String nameInput = '/name_input';
  static const String discovery = '/discovery';
  static const String likes = '/likes';
  static const String qrPass = '/qr_pass';
  static const String career = '/career_step';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      loginOptions: (context) => const LoginOptionsScreen(),
      login: (context) => const LoginScreen(),

      // Registro y Wizard
      nameInput: (context) => const NameInputScreen(),
      career: (context) => const CareerStep(), // El nuevo selector de ingresos

      // Main Tabs Luxy
      discovery: (context) => const DiscoveryPage(), // Swipe Deck dorado
      likes: (context) => const LikesPage(),         // Who liked me con Blur
      qrPass: (context) => const QrPassPage(),       // QR de eventos

      // Home por defecto
      '/home': (context) => const HomeScreen(),
    };
  }
}

// Para usarlo en tu main.dart:
// routes: AppRoutes.getRoutes(),