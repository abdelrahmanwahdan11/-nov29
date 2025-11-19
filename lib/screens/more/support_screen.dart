
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support & Help')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ExpansionTile(
            title: Text('How do I request a car?'),
            children: [Padding(
              padding: EdgeInsets.all(12),
              child: Text('Use the home card and tap request when ready.'),
            )],
          ),
          ExpansionTile(
            title: Text('How to contact support?'),
            children: [Padding(
              padding: EdgeInsets.all(12),
              child: Text('Use chat or email support@nexride.ai'),
            )],
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Emergency assistance'),
            subtitle: Text('+1 305 000 0000'),
          ),
        ],
      ),
    );
  }
}
