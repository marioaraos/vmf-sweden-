import 'dart:io';

import 'package:flutter/material.dart';

import 'birthday_input_screen.dart';
import 'gender_selection_screen.dart';
import 'intro_video_screen.dart';
import 'name_input_screen.dart';
import 'notifications_permission_screen.dart';
import 'photo_upload_multi_screen.dart';
import 'photo_upload_single_screen.dart';
import 'profile_created_screen.dart';
import 'verification_pending_screen.dart';
import 'verification_preview_screen.dart';
import 'welcome_final_screen.dart';

final Map<String, WidgetBuilder> registerRoutes = {
  '/register': (context) => const IntroVideoScreen(),
  '/intro': (context) => const IntroVideoScreen(),
  '/gender': (context) => const GenderSelectionScreen(),
  '/name': (context) => const NameInputScreen(),
  '/birthday': (context) => const BirthdayInputScreen(),
  '/notifications': (context) => const NotificationsPermissionScreen(),
  '/photos_single': (context) => const PhotoUploadSingleScreen(),
  '/photos_multi': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final initialPhoto = args is File ? args : null;
    return PhotoUploadMultiScreen(initialPhoto: initialPhoto);
  },
  '/verification_pending': (context) => const VerificationPendingScreen(),
  '/verification_preview': (context) => const VerificationPreviewScreen(),
  '/profile_created': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final profileImage = args is File ? args : null;
    return ProfileCreatedScreen(userProfileImage: profileImage);
  },
  '/welcome_final': (context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map) {
      final image = args['image'];
      final name = args['name'];
      return WelcomeFinalScreen(
        userProfileImage: image is File ? image : null,
        userName: name is String ? name : "Marjo",
      );
    }
    return const WelcomeFinalScreen();
  },
};
