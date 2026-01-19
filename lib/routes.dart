import 'package:flutter/material.dart';
// Importaciones originales de tu repositorio
import 'screens/splash_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/login/login_options_screen.dart';
import 'screens/registration/name_input_screen.dart';
import 'screens/registration/birthday_input_screen.dart';
import 'screens/registration/gender_selection_screen.dart';
import 'screens/registration/photo_upload_screen.dart';
import 'screens/home_screen.dart';

// Importaciones de las nuevas pantallas en la carpeta lib/ui
import 'ui/discovery_page.dart';
import 'ui/likes_page.dart';
import 'ui/career_step.dart';
import 'ui/qr_pass_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // Rutas iniciales y de autenticación
  '/': (context) => const SplashScreen(),
  '/login_options': (context) => const LoginOptionsScreen(),
  '/login': (context) => const LoginScreen(),

  // Flujo de Registro y Wizard de Perfil
  '/name_input': (context) => const NameInputScreen(),
  '/birthday_input': (context) => const BirthdayInputScreen(),
  '/gender_selection': (context) => const GenderSelectionScreen(),
  '/photo_upload': (context) => const PhotoUploadScreen(),
  '/career_step': (context) => const CareerStep(), // Nuevo selector de ingresos dorado

  // Secciones principales "Luxy Real"
  '/discovery': (context) => const DiscoveryPage(), // Swipe Deck con cards doradas
  '/likes': (context) => const LikesPage(),         // Pantalla con Blur para no-BLACK
  '/qr_pass': (context) => const QrPassPage(),       // Pase de eventos exclusivo

  // Home y otros
  '/home': (context) => const HomeScreen(),
};