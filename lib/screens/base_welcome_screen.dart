import 'package:flutter/material.dart';
import '../app_routes.dart';

class BaseWelcomeScreen extends StatelessWidget {
  const BaseWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido',
                style: textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Tu aplicacion base esta lista para crecer paso a paso.',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              _InfoRow(
                icon: Icons.layers_outlined,
                title: 'Estructura limpia',
                subtitle: 'Pantallas, rutas y tema listos.',
              ),
              const SizedBox(height: 16),
              _InfoRow(
                icon: Icons.bolt_outlined,
                title: 'Inicio rapido',
                subtitle: 'Navegacion base para avanzar hoy.',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.home);
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Comenzar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
