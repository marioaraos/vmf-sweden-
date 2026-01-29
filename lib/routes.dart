import 'package:flutter/material.dart';

import 'package:vmf_lux_project/screens/login/login_options_screen.dart';
import 'package:vmf_lux_project/screens/login/login_screen.dart';
import 'package:vmf_lux_project/screens/messages_screen.dart';
import 'package:vmf_lux_project/screens/profile_screen.dart';
import 'package:vmf_lux_project/screens/events_screen.dart';
import 'package:vmf_lux_project/screens/splash_screen.dart';
import 'package:vmf_lux_project/screens/registration/register_routes.dart';
import 'package:vmf_lux_project/ui/career_step.dart';
import 'package:vmf_lux_project/ui/discovery_page.dart';
import 'package:vmf_lux_project/ui/likes_page.dart';
import 'package:vmf_lux_project/ui/main_shell.dart';
import 'package:vmf_lux_project/ui/qr_pass_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),

  ...registerRoutes,

  '/login_options': (context) => const LoginOptionsScreen(),
  '/login': (context) => const LoginScreen(),

  '/career_step': (context) => const CareerStep(),

  '/home': (context) => const MainShell(),

  '/discovery': (context) => const DiscoveryPage(),
  '/likes': (context) => const LikesPage(),
  '/events': (context) => const EventsScreen(),
  '/qr_pass': (context) => const QrPassPage(),
  '/profile': (context) => const ProfilePage(),
  '/messages': (context) => const MessagesScreen(),
};