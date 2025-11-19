
import 'package:flutter/material.dart';

import '../music/music_experience_screen.dart';
import '../more/settings_screen.dart';
import '../more/support_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ListTile(
          title: const Text('Music experience'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MusicExperienceScreen()),
          ),
        ),
        ListTile(
          title: const Text('Settings'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          ),
        ),
        ListTile(
          title: const Text('Support'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SupportScreen()),
          ),
        ),
      ],
    );
  }
}
