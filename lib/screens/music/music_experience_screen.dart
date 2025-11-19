
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../data/mock/mock_data.dart';

class MusicExperienceScreen extends StatelessWidget {
  const MusicExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final music = ControllerScope.of(context).music;
    final current = music.current;
    return Scaffold(
      appBar: AppBar(title: const Text('Ride playlist')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [Theme.of(context).colorScheme.primary, Colors.pinkAccent],
              ),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(current.coverImageUrl, height: 180, fit: BoxFit.cover),
                ),
                const SizedBox(height: 12),
                Text(current.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white)),
                const SizedBox(height: 4),
                Text(current.artist, style: const TextStyle(color: Colors.white70)),
                Slider(
                  value: music.progress,
                  onChanged: (_) {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: music.toggle,
                        icon: const Icon(Icons.play_arrow, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 20),
          const Text('Playlist'),
          const SizedBox(height: 12),
          ...playlist.map(
            (track) => ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(track.coverImageUrl)),
              title: Text(track.title),
              subtitle: Text(track.artist),
              trailing: Text('${track.durationSec ~/ 60}:${(track.durationSec % 60).toString().padLeft(2, '0')}'),
              onTap: () => music.select(track),
            ),
          ),
        ],
      ),
    );
  }
}
