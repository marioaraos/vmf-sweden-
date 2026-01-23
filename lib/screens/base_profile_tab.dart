import 'package:flutter/material.dart';

class BaseProfileTab extends StatelessWidget {
  const BaseProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              'TU',
              style: textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'Tu Perfil',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text(
            'Completa los datos para personalizar tu app.',
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Column(
            children: const [
              _ProfileOption(
                icon: Icons.person_outline,
                label: 'Datos personales',
              ),
              Divider(height: 1),
              _ProfileOption(
                icon: Icons.settings_outlined,
                label: 'Configuracion',
              ),
              Divider(height: 1),
              _ProfileOption(
                icon: Icons.logout_outlined,
                label: 'Cerrar sesion',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
