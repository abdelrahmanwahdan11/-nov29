
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final controllers = ControllerScope.of(context);
    final theme = controllers.theme;
    final localization = controllers.localization;
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Theme mode'),
          SegmentedButton<ThemeMode>(
            segments: const [
              ButtonSegment(value: ThemeMode.light, label: Text('Light')),
              ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
            ],
            selected: {theme.mode},
            onSelectionChanged: (value) => theme.updateMode(value.first),
          ),
          const SizedBox(height: 20),
          const Text('Primary color'),
          Wrap(
            spacing: 12,
            children: [
              Colors.blue,
              Colors.green,
              Colors.orange,
              Colors.pink,
            ]
                .map((color) => GestureDetector(
                      onTap: () => theme.updatePrimary(color),
                      child: CircleAvatar(backgroundColor: color),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          const Text('Language'),
          DropdownButton<Locale>(
            value: localization.locale,
            onChanged: (value) {
              if (value != null) localization.setLocale(value);
            },
            items: const [
              DropdownMenuItem(value: Locale('en', 'US'), child: Text('English')),
              DropdownMenuItem(value: Locale('ar', 'PS'), child: Text('Arabic')),
            ],
          ),
        ],
      ),
    );
  }
}
