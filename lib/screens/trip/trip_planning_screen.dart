
import 'package:flutter/material.dart';

import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';

class TripPlanningScreen extends StatelessWidget {
  const TripPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trip planning')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            child: Column(
              children: const [
                TextField(decoration: InputDecoration(labelText: 'Pickup')),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: 'Dropoff')),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.network(
              'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
            ),
          ),
          const SizedBox(height: 20),
          const AIInfoButton(),
        ],
      ),
    );
  }
}
