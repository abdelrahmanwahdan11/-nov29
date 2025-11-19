import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/journey_moment.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class JourneyMomentsScreen extends StatefulWidget {
  const JourneyMomentsScreen({super.key});

  @override
  State<JourneyMomentsScreen> createState() => _JourneyMomentsScreenState();
}

class _JourneyMomentsScreenState extends State<JourneyMomentsScreen> {
  final PageController _controller = PageController(viewportFraction: 0.9);
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Journey moments')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (value) => setState(() => _index = value),
              itemCount: journeyMoments.length,
              itemBuilder: (context, index) {
                final moment = journeyMoments[index];
                return _MomentHero(moment: moment).animate().fadeIn().scale();
              },
            ),
          ),
          const SizedBox(height: 12),
          _DotsIndicator(activeIndex: _index, total: journeyMoments.length),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: journeyMoments[_index].storySegments.length,
              itemBuilder: (context, index) {
                final text = journeyMoments[_index].storySegments[index];
                return GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: journeyMoments[_index]
                            .accentColor
                            .withOpacity(0.15),
                        child: Text('${index + 1}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: journeyMoments[_index].accentColor,
                              fontWeight: FontWeight.bold,
                            )),
                      ).animate().scale(delay: (index * 60).ms),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          text,
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ).animate().slideX(begin: 0.1, delay: (index * 80).ms);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
        child: PrimaryButton(
          label: 'Replay this journey',
          onPressed: () {},
        ).animate().shimmer(delay: 300.ms, duration: 1200.ms),
      ),
    );
  }
}

class _MomentHero extends StatelessWidget {
  const _MomentHero({required this.moment});

  final JourneyMoment moment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GlassCard(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(moment.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.4), Colors.black87],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: moment.accentColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      moment.metricLabel,
                      style: theme.textTheme.labelLarge
                          ?.copyWith(color: moment.accentColor),
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  const Spacer(),
                  Text(
                    moment.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ).animate().slideY(begin: 0.2, duration: 400.ms),
                  const SizedBox(height: 6),
                  Text(
                    moment.subtitle,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  GlassCard(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timeline, size: 18),
                        const SizedBox(width: 8),
                        Text(moment.metricValue,
                            style: theme.textTheme.titleMedium),
                      ],
                    ),
                  ).animate().scale(begin: 0.9),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.activeIndex, required this.total});

  final int activeIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        total,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 10,
          width: index == activeIndex ? 26 : 10,
          decoration: BoxDecoration(
            color: index == activeIndex
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.primary.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
