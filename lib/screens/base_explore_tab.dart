import 'package:flutter/material.dart';

class BaseExploreTab extends StatelessWidget {
  const BaseExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Explora ideas',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Agrega modulos segun tus prioridades.',
          style: textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _FeatureChip(label: 'Login'),
            _FeatureChip(label: 'Notificaciones'),
            _FeatureChip(label: 'Pagos'),
            _FeatureChip(label: 'Mapa'),
            _FeatureChip(label: 'Chat'),
            _FeatureChip(label: 'Analytics'),
          ],
        ),
        const SizedBox(height: 20),
        _SectionCard(
          title: 'Prioriza tu MVP',
          subtitle: 'Selecciona lo esencial para lanzar rapido.',
          icon: Icons.lightbulb_outline,
        ),
      ],
    );
  }
}

class _FeatureChip extends StatelessWidget {
  const _FeatureChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      shape: StadiumBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon),
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
