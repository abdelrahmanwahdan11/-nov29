import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/cabin_mood.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class CabinModesScreen extends StatefulWidget {
  const CabinModesScreen({super.key});

  @override
  State<CabinModesScreen> createState() => _CabinModesScreenState();
}

class _CabinModesScreenState extends State<CabinModesScreen> {
  late final PageController _pageController = PageController(viewportFraction: 0.8);
  int _current = 0;
  bool _isApplying = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _applyMood(CabinMood mood) async {
    if (_isApplying) return;
    setState(() => _isApplying = true);
    await Future.delayed(600.ms);
    if (!mounted) return;
    setState(() => _isApplying = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${mood.title} preset will animate your next ride.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mood = cabinMoods[_current];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cabin mood studio'),
        actions: [
          IconButton(
            tooltip: 'Auto-rotate',
            icon: const Icon(Icons.play_circle_outline),
            onPressed: () async {
              for (var i = 0; i < cabinMoods.length; i++) {
                await Future.delayed(500.ms);
                if (!mounted) return;
                final next = (i + 1) % cabinMoods.length;
                _pageController.animateToPage(
                  next,
                  duration: 450.ms,
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _pageController,
              itemCount: cabinMoods.length,
              onPageChanged: (value) => setState(() => _current = value),
              itemBuilder: (context, index) {
                final item = cabinMoods[index];
                final isActive = index == _current;
                return AnimatedScale(
                  duration: 350.ms,
                  scale: isActive ? 1 : 0.92,
                  child: _MoodCard(mood: item, isActive: isActive),
                );
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
              children: [
                AnimatedSwitcher(
                  duration: 400.ms,
                  child: GlassCard(
                    key: ValueKey(mood.id),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mood.badge,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(letterSpacing: 1.1))
                            .animate()
                            .slideX(begin: -0.2, duration: 250.ms),
                        const SizedBox(height: 8),
                        Text(mood.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold))
                            .animate()
                            .fadeIn(),
                        Text(mood.subtitle, style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 12),
                        Text(mood.description),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _ScoreTile(
                                label: 'Focus',
                                value: mood.focusScore,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _ScoreTile(
                                label: 'Energy',
                                value: mood.energyScore,
                                color: const Color(0xFFFF6FD8),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text('Rituals', style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final ritual in mood.rituals)
                              Chip(
                                label: Text(ritual),
                              ).animate().scale(duration: 250.ms),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: PrimaryButton(
              label: 'Apply ${mood.title}',
              isLoading: _isApplying,
              onPressed: () => _applyMood(mood),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  const _MoodCard({required this.mood, required this.isActive});

  final CabinMood mood;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 350.ms,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: mood.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: mood.gradient.last.withOpacity(0.4),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                mood.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mood.title,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  mood.subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white70),
                ),
                const Spacer(),
                AnimatedOpacity(
                  duration: 300.ms,
                  opacity: isActive ? 1 : 0.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text('Tap to expand', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .slideY(begin: 0.1, duration: 400.ms, curve: Curves.easeOut)
        .shimmer(duration: 1200.ms);
  }
}

class _ScoreTile extends StatelessWidget {
  const _ScoreTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: LinearProgressIndicator(
            minHeight: 10,
            value: value,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ).animate().slideX(begin: -0.2, duration: 250.ms),
        const SizedBox(height: 6),
        Text('${(value * 100).round()}%',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
