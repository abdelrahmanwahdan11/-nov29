import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/glass_card.dart';

class SafetyTipsScreen extends StatelessWidget {
  const SafetyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      'Verify vehicle hologram before boarding.',
      'Use built-in SOS widget for any unexpected stops.',
      'Share your trip timeline with trusted contacts.',
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Safety centre')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return GlassCard(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(child: Text('${index + 1}')),
                const SizedBox(width: 12),
                Expanded(child: Text(tips[index])),
              ],
            ),
          ).animate().fadeIn(delay: (index * 80).ms);
        },
      ),
    );
  }
}
