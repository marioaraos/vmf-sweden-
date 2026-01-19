import 'package:flutter/material.dart';
import 'dart:io';

// 1. IMPORTACIÓN CRÍTICA: Contenedor de Navegación de Burbujas
import 'package:vmf_lux_project/ui/main_shell.dart';

// Importaciones de Registro
import 'package:vmf_lux_project/screens/registration/profile_created_screen.dart';
import 'package:vmf_lux_project/screens/registration/intro_video_screen.dart';
import 'package:vmf_lux_project/screens/registration/gender_selection_screen.dart';
import 'package:vmf_lux_project/screens/registration/name_input_screen.dart';
import 'package:vmf_lux_project/screens/registration/birthday_input_screen.dart';
import 'package:vmf_lux_project/screens/registration/notifications_permission_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_single_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_multi_screen.dart';
import 'package:vmf_lux_project/screens/registration/welcome_final_screen.dart';

// Importaciones de Login
import 'package:vmf_lux_project/screens/login/login_screen.dart';
import 'package:vmf_lux_project/screens/login/login_options_screen.dart';

// Otras Pantallas
import 'package:vmf_lux_project/screens/home_screen.dart';
import 'package:vmf_lux_project/screens/discover_screen.dart';
import 'package:vmf_lux_project/screens/events_screen.dart';
import 'package:vmf_lux_project/screens/profile_screen.dart';
import 'package:vmf_lux_project/screens/messages_screen.dart';

// Nuevas Pantallas Luxy (Ubicadas en lib/ui)
import 'package:vmf_lux_project/ui/discovery_page.dart';
import 'package:vmf_lux_project/ui/likes_page.dart';
import 'package:vmf_lux_project/ui/career_step.dart';
import 'package:vmf_lux_project/ui/qr_pass_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // RUTA INICIAL
  '/': (context) => const ProfileCreatedScreen(),
  '/intro': (context) => const IntroVideoScreen(),

  // RUTAS DE LOGIN
  '/login_options': (context) => const LoginOptionsScreen(),
  '/login': (context) => const LoginScreen(),

  // FLUJO DE REGISTRO
  '/gender': (context) => const GenderSelectionScreen(),
  '/name': (context) => const NameInputScreen(),
  '/birthday': (context) => const BirthdayInputScreen(),
  '/career_step': (context) => const CareerStep(),

  // 2. CAMBIO CLAVE: La ruta /home ahora carga el MainShell para mostrar las burbujas
  '/home': (context) => const MainShell(),

  // RUTAS DE PESTAÑAS (Opcionales para navegación directa)
  '/discovery': (context) => const DiscoveryPage(),
  '/likes': (context) => const LikesPage(),
  '/events': (context) => const EventsScreen(),
  '/qr_pass': (context) => const QrPassPage(),
  '/profile': (context) => const ProfilePage(),
  '/messages': (context) => const MessagesScreen(),
};