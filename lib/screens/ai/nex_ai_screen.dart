
import 'package:flutter/material.dart';

class NexAIScreen extends StatelessWidget {
  const NexAIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nex-AI')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(
            leading: Icon(Icons.auto_awesome),
            title: Text('Smart route planning'),
            subtitle: Text('AI will study habits and deliver faster pickups.'),
          ),
          ListTile(
            leading: Icon(Icons.eco),
            title: Text('Eco guidance'),
            subtitle: Text('Expect battery health tips and carbon savings.'),
          ),
          ListTile(
            leading: Icon(Icons.shield),
            title: Text('Safety cues'),
            subtitle: Text('Contextual nudges and instant help coming soon.'),
          ),
        ],
      ),
    );
  }
}
