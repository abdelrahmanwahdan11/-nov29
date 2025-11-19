import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../widgets/glass_card.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({super.key});

  @override
  State<WellnessScreen> createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Ride wellness')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cabin harmony score',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Adaptive lighting + music presets kept you calm during peak traffic.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 12,
                        children: const [
                          _PulseChip(label: 'Breathing coach'),
                          _PulseChip(label: 'Seat therapy'),
                          _PulseChip(label: 'Aroma boost'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final progress = 0.72 + sin(_controller.value * pi) * 0.12;
                    return SizedBox(
                      width: 110,
                      height: 110,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 10,
                            backgroundColor: palette.surfaceVariant.withOpacity(0.2),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(palette.primary),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${(progress * 100).round()}%',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              const SizedBox(height: 4),
                              const Text('Zen index'),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 24),
          Text(
            'Wellness metrics',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ...wellnessMetrics.map((metric) {
            final normalized = (metric.value / 150).clamp(0.0, 1.0);
            final trendColor = metric.trend >= 0 ? Colors.greenAccent : Colors.orangeAccent;
            return GlassCard(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(metric.label,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            metric.trend >= 0
                                ? Icons.arrow_outward_rounded
                                : Icons.arrow_downward_rounded,
                            color: trendColor,
                          ),
                          Text('${metric.trend.abs()}%',
                              style: TextStyle(color: trendColor)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    metric.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: normalized),
                    duration: 600.ms,
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          value: value,
                          backgroundColor: palette.surfaceVariant.withOpacity(0.3),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(palette.primary),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text('${metric.value.toStringAsFixed(0)} ${metric.unit} recorded'),
                ],
              ),
            ).animate().slideY(begin: 0.1, duration: 400.ms);
          }),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Micro rituals',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: const [
                    _RitualTile(
                      title: 'Sonic bubble',
                      description: 'Softens city sirens automatically when stress spikes.',
                    ),
                    _RitualTile(
                      title: 'Hydrate nudge',
                      description: 'Reminder shows when cabin humidity drops.',
                    ),
                    _RitualTile(
                      title: 'Posture pulse',
                      description: 'Seat quietly inflates to align your spine.',
                    ),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms),
        ],
      ),
    );
  }
}

class _PulseChip extends StatelessWidget {
  const _PulseChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
    );
  }
}

class _RitualTile extends StatelessWidget {
  const _RitualTile({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
