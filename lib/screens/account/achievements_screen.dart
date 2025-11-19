import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../widgets/glass_card.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Achievements')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weekly streak',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Unlock badges by riding with NexRide at least once every day. '
                  'AI tunes future rewards based on your patterns.',
                ),
                const SizedBox(height: 18),
                Row(
                  children: List.generate(
                    7,
                    (index) => Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: index == 6 ? 0 : 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: index < 5
                                ? [
                                    theme.colorScheme.primary,
                                    theme.colorScheme.primary
                                        .withOpacity(0.4),
                                  ]
                                : [Colors.white10, Colors.white12],
                          ),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.25)),
                        ),
                        child: Column(
                          children: [
                            Text('D${index + 1}'),
                            Icon(
                              index < 5
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              size: 18,
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: (index * 70).ms),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Badges', style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          ...achievements.map(
            (achievement) => GlassCard(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(achievement.badgeImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).animate().scale(
                        duration: 300.ms, curve: Curves.easeOutBack),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.title,
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(achievement.description,
                            style: theme.textTheme.bodySmall),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: achievement.progress,
                            minHeight: 8,
                            backgroundColor: Colors.white12,
                            valueColor:
                                AlwaysStoppedAnimation(achievement.accent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    children: [
                      Text('${(achievement.progress * 100).round()}%'),
                      const Text('Ready',
                          style:
                              TextStyle(fontSize: 12, color: Colors.white60)),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.1).fadeIn(),
          ),
          const SizedBox(height: 24),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Next unlock',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Icon(Icons.celebration_outlined),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Request one more eco ride this week to unlock carbon offset multipliers.',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
