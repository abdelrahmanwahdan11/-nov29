import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/fleet_update.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class FleetUpdatesScreen extends StatefulWidget {
  const FleetUpdatesScreen({super.key});

  @override
  State<FleetUpdatesScreen> createState() => _FleetUpdatesScreenState();
}

class _FleetUpdatesScreenState extends State<FleetUpdatesScreen> {
  late final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentPage = 0;
  bool _joiningWaitlist = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(650.ms);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _joinWaitlist() async {
    if (_joiningWaitlist) return;
    setState(() => _joiningWaitlist = true);
    await Future.delayed(900.ms);
    if (!mounted) return;
    setState(() => _joiningWaitlist = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You'll get Aurora/Fleet alerts the moment they open."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fleet updates'),
        actions: [
          IconButton(
            tooltip: 'Auto-play cards',
            icon: const Icon(Icons.play_circle_outline),
            onPressed: () async {
              for (var i = 0; i < fleetUpdates.length; i++) {
                await Future.delayed(500.ms);
                if (!mounted) return;
                final next = (i + 1) % fleetUpdates.length;
                _pageController.animateToPage(
                  next,
                  duration: 400.ms,
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            SizedBox(
              height: 300,
              child: PageView.builder(
                controller: _pageController,
                itemCount: fleetUpdates.length,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemBuilder: (context, index) {
                  final update = fleetUpdates[index];
                  return AnimatedScale(
                    duration: 300.ms,
                    scale: _currentPage == index ? 1 : 0.94,
                    child: _FleetCard(update: update),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < fleetUpdates.length; i++)
                  AnimatedContainer(
                    duration: 200.ms,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == i ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == i
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.primary.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Production timeline',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold))
                      .animate()
                      .fadeIn(),
                  const SizedBox(height: 16),
                  for (final update in fleetUpdates)
                    _TimelineRow(update: update),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.rocket_launch_outlined),
                      const SizedBox(width: 12),
                      Text('Join a pilot crew',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))
                          .animate()
                          .slideX(begin: 0.2),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                      'Pilot riders get early rituals, mood studios, and voice-to-route experiments. Slots rotate weekly, fully offline.'),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: _joiningWaitlist ? 'Joining...' : 'Join waitlist',
                    isLoading: _joiningWaitlist,
                    onPressed: _joinWaitlist,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Design feedback prompts',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _FeedbackChip(label: 'Cabin layout polls'),
                      _FeedbackChip(label: 'Accessibility tweaks'),
                      _FeedbackChip(label: 'Shared commute experiments'),
                      _FeedbackChip(label: 'Creator cargo setups'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FleetCard extends StatelessWidget {
  const _FleetCard({required this.update});

  final FleetUpdate update;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            colors: update.gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(update.status.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Colors.white.withOpacity(0.8)))
                .animate()
                .fadeIn(),
            const SizedBox(height: 6),
            Text(update.title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                .animate()
                .slideY(begin: 0.2),
            Text(update.subtitle,
                style:
                    Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70)),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                update.imageUrl,
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
              ).animate().fadeIn(),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: Text(update.eta, style: const TextStyle(color: Colors.black)),
                  backgroundColor: Colors.white,
                ),
                for (final chip in update.chips)
                  Chip(
                    label: Text(chip),
                    backgroundColor: Colors.white24,
                    labelStyle: const TextStyle(color: Colors.white),
                  ).animate().scale(duration: 250.ms),
              ],
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 350.ms);
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.update});

  final FleetUpdate update;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 2,
                height: 28,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(update.title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(update.description,
                    style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Chip(label: Text(update.status)),
                    const SizedBox(width: 8),
                    Text(update.eta, style: Theme.of(context).textTheme.bodySmall),
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

class _FeedbackChip extends StatelessWidget {
  const _FeedbackChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      avatar: const Icon(Icons.bolt, size: 16),
    ).animate().scale(duration: 200.ms);
  }
}
