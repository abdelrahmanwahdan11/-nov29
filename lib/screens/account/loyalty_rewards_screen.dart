import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class LoyaltyRewardsScreen extends StatelessWidget {
  const LoyaltyRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Loyalty tiers')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Glow miles overview',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Earned this month',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 12),
                TweenAnimationBuilder<double>(
                  duration: 900.ms,
                  curve: Curves.easeOut,
                  tween: Tween(begin: 0, end: 0.72),
                  builder: (context, value, _) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: value,
                          minHeight: 10,
                          backgroundColor: palette.surfaceVariant.withOpacity(0.4),
                          color: palette.primary,
                        ),
                        const SizedBox(height: 6),
                        Text('${(value * 1200).round()} / 1200 miles'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  children: const [
                    _BenefitChip(label: 'Priority pickup'),
                    _BenefitChip(label: 'Cabin scenes'),
                    _BenefitChip(label: 'Crew boost'),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn().slideY(begin: 0.05),
          const SizedBox(height: 24),
          ...ecoRewards.map(
            (reward) => GlassCard(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            reward.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: reward.accent.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              reward.reward,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ).animate().scale(duration: 350.ms),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    reward.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reward.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 14),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: reward.progress),
                    duration: 700.ms,
                    builder: (context, value, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(
                          value: value,
                          minHeight: 8,
                          color: reward.accent,
                          backgroundColor: reward.accent.withOpacity(0.2),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${(value * 100).round()}% complete'),
                            Text('Streak ${reward.streak}d'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  PrimaryButton(
                    label: 'Boost tier',
                    onPressed: () => _showBoostSheet(context, reward.title),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 80)).slideY(
                  begin: 0.08,
                  duration: 450.ms,
                ),
          ),
        ],
      ),
    );
  }

  void _showBoostSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Boost $title',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enable eco-driving rituals or invite a co-rider to double the aura points for the next ride.',
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                label: 'I’m in',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BenefitChip extends StatelessWidget {
  const _BenefitChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    );
  }
}
