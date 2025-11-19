
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/glass_card.dart';
import '../music/music_experience_screen.dart';
import '../more/eco_insights_screen.dart';
import '../more/labs_screen.dart';
import '../more/safety_tips_screen.dart';
import '../more/settings_screen.dart';
import '../more/support_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _MoreTile(
        title: 'Music experience',
        subtitle: 'Control playlists & immersive cabins',
        icon: Icons.music_note,
        builder: (_) => const MusicExperienceScreen(),
      ),
      _MoreTile(
        title: 'Eco impact',
        subtitle: 'See how NexRide offsets your rides',
        icon: Icons.eco_outlined,
        builder: (_) => const EcoInsightsScreen(),
      ),
      _MoreTile(
        title: 'Nex Labs',
        subtitle: 'Preview future AI upgrades & waitlists',
        icon: Icons.auto_graph_rounded,
        builder: (_) => const LabsScreen(),
      ),
      _MoreTile(
        title: 'Safety centre',
        subtitle: 'Trusted contacts and emergency info',
        icon: Icons.shield_moon,
        builder: (_) => const SafetyTipsScreen(),
      ),
      _MoreTile(
        title: 'Settings',
        subtitle: 'Language, theme, notifications',
        icon: Icons.settings_outlined,
        builder: (_) => const SettingsScreen(),
      ),
      _MoreTile(
        title: 'Support',
        subtitle: 'FAQs, chat and emergency contacts',
        icon: Icons.support_agent,
        builder: (_) => const SupportScreen(),
      ),
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tiles.length,
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return GestureDetector(
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: tile.builder)),
          child: GlassCard(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(tile.icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tile.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold))
                          .animate()
                          .fadeIn(),
                      Text(tile.subtitle,
                              style: Theme.of(context).textTheme.bodySmall)
                          .animate()
                          .slideX(begin: 0.1),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ).animate().scale(begin: 0.97, duration: 300.ms),
        );
      },
    );
  }
}

class _MoreTile {
  _MoreTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;
}
