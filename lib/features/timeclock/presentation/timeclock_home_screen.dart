import 'package:flutter/material.dart';

import '../../../core/config/app_config.dart';
import '../../../shared/widgets/wiloo_scaffold.dart';

class TimeclockHomeScreen extends StatelessWidget {
  const TimeclockHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WilooScaffold(
      title: 'Wiloo Pointage',
      children: [
        Text(
          'Terminal de pointage',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        const Text(
          'Base prete pour les flux PIN, QR, verification visage et pointage.',
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: null,
          icon: const Icon(Icons.pin_outlined),
          label: const Text('Pointage par PIN'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: null,
          icon: const Icon(Icons.qr_code_scanner_outlined),
          label: const Text('Scanner un QR code'),
        ),
        const SizedBox(height: 32),
        Text('API: ${AppConfig.apiBaseUrl}'),
      ],
    );
  }
}
