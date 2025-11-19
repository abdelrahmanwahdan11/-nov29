import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class LabsScreen extends StatelessWidget {
  const LabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = _labsCards;
    return Scaffold(
      appBar: AppBar(title: const Text('Nex Labs')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI research preview',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Every month Nex Labs tests ambient interfaces, predictive dispatch and sustainable perks '
                  'with a limited cohort. These sneak peeks stay offline but inspire what is coming next.',
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  label: 'Join waitlist',
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Coming soon'),
                      content: const Text(
                        'Lab invites are rolling out gradually. You will be notified right inside the app when ready.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 350.ms),
          const SizedBox(height: 20),
          ...cards.map(
            (card) => GlassCard(
              margin: const EdgeInsets.only(bottom: 16),
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    child: Image.network(card.image, height: 160, fit: BoxFit.cover)
                        .animate()
                        .scale(duration: 400.ms, curve: Curves.easeOutCubic),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(card.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 8),
                        Text(card.subtitle,
                            style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          children: const [
                            _TagChip(label: 'Research'),
                            _TagChip(label: 'Glass UI'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().slideX(begin: 0.1).fadeIn(),
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _LabsCard {
  const _LabsCard({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final String image;
}

const _labsCards = [
  _LabsCard(
    title: 'Predictive routing',
    subtitle:
        'AI watches traffic pulses to suggest the smoothest departure windows before you even ask.',
    image:
        'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=80',
  ),
  _LabsCard(
    title: 'Mood-driven cabins',
    subtitle:
        'Sync playlists, ambient lights and seat ergonomics to your current focus level.',
    image:
        'https://images.unsplash.com/photo-1529429617124-aee711a70412?auto=format&fit=crop&w=1200&q=80',
  ),
  _LabsCard(
    title: 'Safety copilots',
    subtitle:
        'Auto-share trips with trusted circles and get comfort prompts when something feels off.',
    image:
        'https://images.unsplash.com/photo-1493238792000-8113da705763?auto=format&fit=crop&w=1200&q=80',
  ),
];
