import 'package:flutter/material.dart';
import 'app_routes.dart';
import 'app_theme.dart';
import 'screens/base_home_shell.dart';
import 'screens/base_welcome_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Base',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (_) => const BaseWelcomeScreen(),
        AppRoutes.home: (_) => const BaseHomeShell(),
      },
    );
  }
}
