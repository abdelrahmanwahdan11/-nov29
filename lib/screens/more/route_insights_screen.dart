import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/route_insight.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class RouteInsightsScreen extends StatelessWidget {
  const RouteInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route insights')),
      body: RefreshIndicator(
        onRefresh: () async => Future<void>.delayed(600.ms),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: routeInsights.length,
          itemBuilder: (context, index) {
            final insight = routeInsights[index];
            return GlassCard(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            insight.mapImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 12,
                          child: AIInfoButton(
                            onTap: () => _showInsight(context, insight),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.05),
                  const SizedBox(height: 14),
                  Text(
                    insight.routeName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${insight.pickup} ➜ ${insight.dropoff}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _DataPill(label: 'Window', value: insight.recommendedWindow),
                      const SizedBox(width: 10),
                      _DataPill(label: 'CO₂', value: insight.co2Saved),
                      const SizedBox(width: 10),
                      _DataPill(label: 'Flow', value: insight.congestionLevel),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    insight.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: insight.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceVariant,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: 'Plan with ${insight.routeName}',
                    onPressed: () => _showPlannerSheet(context, insight),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: Duration(milliseconds: index * 80));
          },
        ),
      ),
    );
  }

  void _showPlannerSheet(BuildContext context, RouteInsight routeInsight) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sync ${routeInsight.routeName}',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${routeInsight.pickup} ➜ ${routeInsight.dropoff}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              const Text(
                'We will mirror these timings inside Trip Planner and remind you 15 minutes before the optimal window.',
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                label: 'Add to planner',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInsight(BuildContext context, RouteInsight routeInsight) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nex-AI note',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'In future versions, AI will adapt this route automatically and keep monitoring wind + traffic sensors for ${routeInsight.routeName}.',
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Sounds good',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DataPill extends StatelessWidget {
  const _DataPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Theme.of(context).colorScheme.outline),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
