import 'package:flutter/material.dart';

class BaseHomeTab extends StatelessWidget {
  const BaseHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Tu base desde cero',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Este es el punto de partida para tus funciones principales.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        _InfoCard(
          title: 'Primeros pasos',
          subtitle: 'Define el objetivo y los flujos clave de tu app.',
          icon: Icons.flag_outlined,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          title: 'Datos esenciales',
          subtitle: 'Conecta tu backend o usa datos locales.',
          icon: Icons.storage_outlined,
        ),
        const SizedBox(height: 12),
        _InfoCard(
          title: 'Pantallas base',
          subtitle: 'Organiza secciones y componentes reutilizables.',
          icon: Icons.dashboard_outlined,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary),
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
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
