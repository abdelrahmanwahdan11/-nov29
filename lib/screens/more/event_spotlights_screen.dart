import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/event_spotlight.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class EventSpotlightsScreen extends StatefulWidget {
  const EventSpotlightsScreen({super.key});

  @override
  State<EventSpotlightsScreen> createState() => _EventSpotlightsScreenState();
}

class _EventSpotlightsScreenState extends State<EventSpotlightsScreen> {
  late final PageController _controller;
  String _category = 'All';

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.86);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = <String>{'All', ...eventSpotlights.map((e) => e.category)}.toList();
    categories.sort();
    final filtered = eventSpotlights
        .where((event) => _category == 'All' || event.category == _category)
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Event spotlights')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          Text('City happenings',
              style:
                  Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Stay ahead of pop-ups, wellness rituals, and summit traffic. AI groups the most impactful happenings for your rides.'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories
                .map(
                  (category) => FilterChip(
                    label: Text(category),
                    selected: _category == category,
                    onSelected: (_) => setState(() => _category = category),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _controller,
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final event = filtered[index];
                return Padding(
                  padding: EdgeInsets.only(right: index == filtered.length - 1 ? 0 : 12),
                  child: _EventHeroCard(event: event),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text('Upcoming cues',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...filtered.asMap().entries.map(
            (entry) => _EventTimelineTile(event: entry.value)
                .animate(delay: (entry.key * 60).ms)
                .fadeIn(),
          ),
        ],
      ),
    );
  }
}

class _EventHeroCard extends StatelessWidget {
  const _EventHeroCard({required this.event});

  final EventSpotlight event;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              event.heroImageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 14),
          Text(event.title,
              style:
                  Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(event.highlight, style: Theme.of(context).textTheme.bodySmall),
          const Spacer(),
          Wrap(
            spacing: 8,
            children: event.chips
                .map((chip) => Chip(
                      label: Text(chip),
                      visualDensity: VisualDensity.compact,
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          PrimaryButton(label: 'See travel brief', onPressed: () {}),
        ],
      ),
    ).animate().scale(begin: 0.95).fadeIn();
  }
}

class _EventTimelineTile extends StatelessWidget {
  const _EventTimelineTile({required this.event});

  final EventSpotlight event;

  @override
  Widget build(BuildContext context) {
    final date = event.dateTime;
    final timeLabel = '${date.month}/${date.day} • ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Theme.of(context).colorScheme.primary.withOpacity(0.16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${date.day}',
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(_monthLabel(date.month), style: const TextStyle(fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${event.venue} • $timeLabel'),
                const SizedBox(height: 4),
                Text(event.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.navigate_next, color: Theme.of(context).colorScheme.primary)
              .animate()
              .slideX(begin: 0.2),
        ],
      ),
    );
  }

  String _monthLabel(int month) {
    const labels = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return labels[(month - 1).clamp(0, 11)];
  }
}
