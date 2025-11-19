import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/pulse_forecast.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';

class PulseForecastScreen extends StatefulWidget {
  const PulseForecastScreen({super.key});

  @override
  State<PulseForecastScreen> createState() => _PulseForecastScreenState();
}

class _PulseForecastScreenState extends State<PulseForecastScreen> {
  late List<PulseForecast> _items = List.of(pulseForecasts);
  bool _refreshing = false;

  Future<void> _refresh() async {
    if (_refreshing) return;
    setState(() => _refreshing = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _items = List.of(pulseForecasts)..shuffle();
      _refreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pulse forecasts'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Center(child: AIInfoButton()),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
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
                        Text('Dynamic route brief',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold))
                            .animate()
                            .fadeIn(),
                        const SizedBox(height: 8),
                        const Text(
                          'AI watches city sensors locally and proposes tiny shifts so your crew dodges the next wave.',
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: 0.72,
                          backgroundColor: Colors.white.withOpacity(0.1),
                        ).animate().slideX(begin: -0.3),
                        const SizedBox(height: 4),
                        Text('72% windows optimised today',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=80',
                        height: 130,
                        fit: BoxFit.cover,
                      ).animate().fadeIn(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(_items.length, (index) {
              final item = _items[index];
              return _ForecastTile(
                index: index,
                item: item,
              );
            }),
            if (_refreshing)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: const Center(child: CircularProgressIndicator()).animate().scale(),
              ),
          ],
        ),
      ),
    );
  }
}

class _ForecastTile extends StatelessWidget {
  const _ForecastTile({required this.item, required this.index});

  final PulseForecast item;
  final int index;

  @override
  Widget build(BuildContext context) {
    final delay = (index * 80).ms;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                ),
                child: Text(item.timeframe, style: Theme.of(context).textTheme.labelMedium),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(item.summary),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Image.network(
                  item.mapImageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 12,
                  top: 12,
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(item.impactLevel, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Estimated delay', style: Theme.of(context).textTheme.labelMedium),
                    Text(item.delayMinutes >= 0
                        ? '+${item.delayMinutes} min'
                        : '${item.delayMinutes.abs()} min boost'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Confidence', style: Theme.of(context).textTheme.labelMedium),
                    LinearProgressIndicator(
                      value: item.confidence,
                    ),
                    Text('${(item.confidence * 100).round()}%'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final tag in item.tags)
                Chip(
                  label: Text(tag),
                ),
            ],
          ),
        ],
      ),
    )
        .animate(delay: delay)
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, duration: 300.ms);
  }
}
