import 'package:flutter/material.dart';
import 'dart:io';

import 'package:vmf_lux_project/screens/registration/profile_created_screen.dart';
import 'package:vmf_lux_project/screens/registration/intro_video_screen.dart';
import 'package:vmf_lux_project/screens/login_screen.dart';
import 'package:vmf_lux_project/screens/registration/gender_selection_screen.dart';
import 'package:vmf_lux_project/screens/registration/name_input_screen.dart';
import 'package:vmf_lux_project/screens/registration/birthday_input_screen.dart';
import 'package:vmf_lux_project/screens/registration/notifications_permission_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_single_screen.dart';
import 'package:vmf_lux_project/screens/registration/photo_upload_multi_screen.dart';
import 'package:vmf_lux_project/screens/registration/welcome_final_screen.dart';
import 'package:vmf_lux_project/screens/home_screen.dart';
import 'package:vmf_lux_project/screens/aura/aura_screen.dart';
import 'package:vmf_lux_project/screens/chat/luxy_chat_screen.dart';
import 'package:vmf_lux_project/screens/live/masterclass_screen.dart';
import 'package:vmf_lux_project/screens/ofrendas/offering_screen.dart';
import 'package:vmf_lux_project/screens/mapa/vmf_map_screen.dart';
import 'package:vmf_lux_project/screens/historia/vmf_history_screen.dart';
import 'package:vmf_lux_project/screens/ofrendas/offering_history_screen.dart';
import 'package:vmf_lux_project/screens/visitors_screen.dart';
import 'package:vmf_lux_project/screens/face_verification_screen.dart';
import 'package:vmf_lux_project/screens/discover_screen.dart';
import 'package:vmf_lux_project/screens/events_screen.dart';
import 'package:vmf_lux_project/screens/profile_screen.dart';
import 'package:vmf_lux_project/screens/messages_screen.dart';
import 'package:vmf_lux_project/screens/community_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const ProfileCreatedScreen(),
  '/intro': (context) => const IntroVideoScreen(),
  '/login': (context) => LoginScreen(),
  '/gender': (context) => const GenderSelectionScreen(),
  '/name': (context) => const NameInputScreen(),
  '/birthday': (context) => const BirthdayInputScreen(),
  '/notifications': (context) => const NotificationsPermissionScreen(),
  '/photos_single': (context) => const PhotoUploadSingleScreen(),
  '/photos_multi': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as File?;
    return PhotoUploadMultiScreen(initialPhoto: args);
  },
  '/profile_created': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as File?;
    return ProfileCreatedScreen(userProfileImage: args);
  },
  '/welcome_video': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as File?;
    return WelcomeFinalScreen(userProfileImage: args);
  },
  '/home': (context) => const HomeScreen(),
  '/sanctuary': (context) => const ProfileCreatedScreen(),
  '/aura': (context) => const AuraScreen(),
  '/chat': (context) => const LuxyChatScreen(),
  '/live': (context) => const MasterclassScreen(),
  '/offering': (context) => const OfferingScreen(),
  '/map': (context) => const VMFMapScreen(),
  '/history': (context) => const VMFHistoryScreen(),
  '/offering_history': (context) => const OfferingHistoryScreen(),
  '/visitors': (context) => const VisitorsScreen(),
  '/face_verification': (context) => const FaceVerificationScreen(),
  '/discover': (context) => const DiscoverScreen(),
  '/events': (context) => const EventsScreen(),
  '/profile': (context) => const ProfilePage(),
  '/messages': (context) => const MessagesScreen(),
  '/community': (context) => const CommunityScreen(),
};
