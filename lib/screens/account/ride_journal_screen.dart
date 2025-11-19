import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/ride_journal_entry.dart';
import '../../widgets/glass_card.dart';

class RideJournalScreen extends StatefulWidget {
  const RideJournalScreen({super.key});

  @override
  State<RideJournalScreen> createState() => _RideJournalScreenState();
}

class _RideJournalScreenState extends State<RideJournalScreen> {
  final _filters = ['All', 'Focus', 'Crew', 'Wellness'];
  String _selectedFilter = 'All';
  bool _isRefreshing = false;

  List<RideJournalEntry> get _entries {
    if (_selectedFilter == 'All') {
      return rideJournalEntries;
    }
    return rideJournalEntries
        .where((element) => element.tags.any((tag) =>
            tag.toLowerCase().contains(_selectedFilter.toLowerCase())))
        .toList();
  }

  Future<void> _refresh() async {
    if (_isRefreshing) return;
    setState(() => _isRefreshing = true);
    await Future.delayed(600.ms);
    if (!mounted) return;
    setState(() => _isRefreshing = false);
  }

  void _showHighlights(RideJournalEntry entry) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GlassCard(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold))
                  .animate()
                  .slideX(begin: -0.1),
              Text(entry.route, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 12),
              ...entry.highlights
                  .map(
                    (highlight) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.auto_awesome, color: entry.accent, size: 16),
                          const SizedBox(width: 8),
                          Expanded(child: Text(highlight)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride journal'),
        actions: [
          IconButton(
            tooltip: 'Shuffle mood',
            icon: const Icon(Icons.auto_fix_high_outlined),
            onPressed: () {
              setState(() {
                final currentIndex = _filters.indexOf(_selectedFilter);
                _selectedFilter =
                    _filters[(currentIndex + 1) % _filters.length];
              });
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Journaling keeps your rides intentional',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold))
                      .animate()
                      .fadeIn(duration: 350.ms),
                  const SizedBox(height: 8),
                  Text(
                      'Capture highlights, cabin moods, and AI nudges. NexRide\'s assistant evolves with every reflection.'),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (final filter in _filters)
                        FilterChip(
                          label: Text(filter),
                          selected: filter == _selectedFilter,
                          onSelected: (_) => setState(() => _selectedFilter = filter),
                        ).animate().scale(duration: 250.ms, delay: 80.ms * _filters.indexOf(filter)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ..._entries.map((entry) => _TimelineCard(
                  entry: entry,
                  onHighlights: () => _showHighlights(entry),
                )),
            if (_entries.isEmpty)
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.sensors_off, size: 48),
                    const SizedBox(height: 8),
                    const Text('No entries for this vibe yet'),
                    Text('Pull to refresh or switch filters',
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
            if (_isRefreshing)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: const LinearProgressIndicator(minHeight: 3)
                    .animate()
                    .slideX(begin: -0.3),
              ),
          ],
        ),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({
    required this.entry,
    required this.onHighlights,
  });

  final RideJournalEntry entry;
  final VoidCallback onHighlights;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: [
          Positioned(
            left: 24,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [entry.accent.withOpacity(0.2), entry.accent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          GlassCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: entry.accent,
                        shape: BoxShape.circle,
                      ),
                    ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(entry.title,
                              style: theme.textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700))
                          .animate()
                          .fadeIn(),
                    ),
                    Icon(Icons.star, color: entry.accent),
                    const SizedBox(width: 4),
                    Text(entry.rating.toStringAsFixed(1)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(entry.route, style: theme.textTheme.bodySmall),
                const SizedBox(height: 8),
                Text(entry.note),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      backgroundColor: entry.accent.withOpacity(0.12),
                      label: Text(entry.mood),
                    ),
                    Chip(label: Text(entry.vehicle)),
                    for (final tag in entry.tags)
                      Chip(
                        label: Text(tag),
                      ).animate().scale(duration: 250.ms),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '${entry.timestamp.hour.toString().padLeft(2, '0')}:${entry.timestamp.minute.toString().padLeft(2, '0')} • '
                      '${entry.timestamp.month}/${entry.timestamp.day}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: onHighlights,
                      icon: const Icon(Icons.menu_book_outlined),
                      label: const Text('Highlights'),
                    ),
                  ],
                ),
              ],
            ),
          ).animate().slideY(begin: 0.1, duration: 350.ms),
        ],
      ),
    );
  }
}
