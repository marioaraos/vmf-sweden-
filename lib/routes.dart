import 'package:flutter/material.dart';

// Importaciones de Registro
import 'package:vmf_lux_project/screens/registration/intro_video_screen.dart';
import 'package:vmf_lux_project/screens/registration/gender_selection_screen.dart';
import 'package:vmf_lux_project/screens/registration/name_input_screen.dart';
import 'package:vmf_lux_project/screens/registration/birthday_input_screen.dart';
import 'package:vmf_lux_project/screens/registration/notifications_permission_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_single_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_multi_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_screen.dart';
import 'package:vmf_lux_project/screens/registration/profile_created_screen.dart';
import 'package:vmf_lux_project/screens/registration/welcome_final_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  // RUTA INICIAL
  '/': (context) => const IntroVideoScreen(),
  '/intro': (context) => const IntroVideoScreen(),

  // FLUJO DE REGISTRO
  '/gender': (context) => const GenderSelectionScreen(),
  '/name': (context) => const NameInputScreen(),
  '/birthday': (context) => const BirthdayInputScreen(),
  '/notifications': (context) => const NotificationsPermissionScreen(),
  '/photos_single': (context) => const PhotoUploadSingleScreen(),
  '/photos_multi': (context) => const PhotoUploadMultiScreen(),
  '/photos_grid': (context) => const PhotoUploadScreen(),
  '/profile_created': (context) => const ProfileCreatedScreen(),
  '/welcome_final': (context) => const WelcomeFinalScreen(),
};