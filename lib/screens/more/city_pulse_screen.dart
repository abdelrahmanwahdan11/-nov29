import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/city_pulse_story.dart';
import '../../widgets/glass_card.dart';

class CityPulseScreen extends StatefulWidget {
  const CityPulseScreen({super.key});

  @override
  State<CityPulseScreen> createState() => _CityPulseScreenState();
}

class _CityPulseScreenState extends State<CityPulseScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _controller;
  late final AnimationController _ticker;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.86);
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City pulse'),
        actions: [
          IconButton(
            onPressed: () => setState(() {}),
            icon: const Icon(Icons.refresh_rounded),
          ).animate().rotate(duration: 600.ms),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 40),
        children: [
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _controller,
              itemCount: cityPulseStories.length,
              itemBuilder: (context, index) {
                final story = cityPulseStories[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20, right: 12),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      double page = 0;
                      if (_controller.hasClients &&
                          _controller.position.haveDimensions) {
                        page = _controller.page ?? _controller.initialPage.toDouble();
                      }
                      final delta = (index - page).clamp(-1.0, 1.0);
                      final scale = 1 - (delta.abs() * 0.08);
                      return Transform.scale(
                        scale: scale,
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                    child: _PulseHeroCard(story: story, ticker: _ticker),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Trending signals',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ).animate().fadeIn(),
          ),
          const SizedBox(height: 12),
          ...cityPulseStories.map(
            (story) => GlassCard(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        story.tag.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Text(
                          story.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _timeAgo(story.publishedAt),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ).animate().fadeIn(delay: (cityPulseStories.indexOf(story) * 120).ms),
          ),
        ],
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours} h ago';
    return '${diff.inDays} d ago';
  }
}

class _PulseHeroCard extends StatelessWidget {
  const _PulseHeroCard({required this.story, required this.ticker});

  final AnimationController ticker;
  final CityPulseStory story;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                story.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.25),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.65),
                    Colors.black.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(
                    label: Text(story.tag),
                    backgroundColor: Colors.white.withOpacity(0.18),
                  ).animate().fadeIn(duration: 500.ms),
                  const Spacer(),
                  Text(
                    story.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ).animate().moveY(begin: 20, duration: 500.ms),
                  const SizedBox(height: 8),
                  Text(
                    story.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  AnimatedBuilder(
                    animation: ticker,
                    builder: (context, _) {
                      final value = 0.5 + sin(ticker.value * pi * 2) * 0.5;
                      return Opacity(
                        opacity: 0.7 + (value * 0.3),
                        child: Text(
                          story.highlight ?? 'Live city desk update',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}
