import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/stat_pill.dart';

class EcoInsightsScreen extends StatelessWidget {
  const EcoInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = const [
      {'label': 'CO₂ saved', 'value': '184 kg', 'icon': Icons.eco_outlined},
      {'label': 'Trees planted', 'value': '12', 'icon': Icons.park},
      {'label': 'Silent rides', 'value': '48%', 'icon': Icons.bedtime},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Eco impact')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: stats
                .map((stat) => StatPill(
                      label: stat['label'] as String,
                      value: stat['value'] as String,
                      icon: stat['icon'] as IconData,
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Weekly sustainability tips',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 8),
                Text('Schedule rides before rush hours to unlock shared routes '
                    'and reduce emissions by another 12%.'),
              ],
            ),
          ).animate().fadeIn(),
        ],
      ),
    );
  }
}
