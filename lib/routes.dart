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
import 'package:vmf_lux_project/screens/community_screen.dart';
import 'package:vmf_lux_project/screens/aura/aura_screen.dart';
import 'package:vmf_lux_project/screens/chat/luxy_chat_screen.dart';
import 'package:vmf_lux_project/screens/face_verification_screen.dart';
import 'package:vmf_lux_project/screens/historia/vmf_history_screen.dart';
import 'package:vmf_lux_project/screens/live/masterclass_screen.dart';
import 'package:vmf_lux_project/screens/mapa/vmf_map_screen.dart';
import 'package:vmf_lux_project/screens/ofrendas/offering_screen.dart';
import 'package:vmf_lux_project/screens/sanctuary_screen.dart';
import 'package:vmf_lux_project/screens/terms_screen.dart';
import 'package:vmf_lux_project/screens/visitors_screen.dart';

// Nuevas Pantallas Luxy (Ubicadas en lib/ui)
import 'package:vmf_lux_project/ui/discovery_page.dart';
import 'package:vmf_lux_project/ui/likes_page.dart';
import 'package:vmf_lux_project/ui/career_step.dart';
import 'package:vmf_lux_project/ui/qr_pass_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // RUTA INICIAL
  '/': (context) => const ProfileCreatedScreen(),
  '/intro': (context) => const IntroVideoScreen(),
  '/register': (context) => const IntroVideoScreen(),

  // RUTAS DE LOGIN
  '/login_options': (context) => const LoginOptionsScreen(),
  '/login': (context) => const LoginScreen(),

  // FLUJO DE REGISTRO
  '/gender': (context) => const GenderSelectionScreen(),
  '/name': (context) => const NameInputScreen(),
  '/birthday': (context) => const BirthdayInputScreen(),
  '/career_step': (context) => const CareerStep(),
  '/notifications': (context) => const NotificationsPermissionScreen(),
  '/photos_single': (context) => const PhotoUploadSingleScreen(),
  '/photos_multi': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is File) {
      return PhotoUploadMultiScreen(initialPhoto: args);
    }
    return const PhotoUploadMultiScreen();
  },
  '/profile_created': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is File) {
      return ProfileCreatedScreen(userProfileImage: args);
    }
    return const ProfileCreatedScreen();
  },

  // 2. CAMBIO CLAVE: La ruta /home ahora carga el MainShell para mostrar las burbujas
  '/home': (context) => const MainShell(),

  // RUTAS DE PESTAÑAS (Opcionales para navegación directa)
  '/discovery': (context) => const DiscoveryPage(),
  '/discover': (context) => const DiscoverScreen(),
  '/likes': (context) => const LikesPage(),
  '/events': (context) => const EventsScreen(),
  '/qr_pass': (context) => const QrPassPage(),
  '/profile': (context) => const ProfilePage(),
  '/messages': (context) => const MessagesScreen(),
  '/community': (context) => const CommunityScreen(),
  '/aura': (context) => const AuraScreen(),
  '/live': (context) => const MasterclassScreen(),
  '/offering': (context) => const OfferingScreen(),
  '/history': (context) => const VMFHistoryScreen(),
  '/chat': (context) => const LuxyChatScreen(),
  '/visitors': (context) => const VisitorsScreen(),
  '/map': (context) => const VMFMapScreen(),
  '/face_verification': (context) => const FaceVerificationScreen(),
  '/sanctuary': (context) => const SanctuaryScreen(),
  '/terms': (context) => const TermsScreen(),
};