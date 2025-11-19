import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/glass_card.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        'title': 'Glass VIP tier',
        'desc': 'Complete 3 eco rides to unlock 20% off airport transfers',
        'status': 'Active'
      },
      {
        'title': 'Nightride playlist',
        'desc': 'Ride after 9pm this week to receive curated mood mixes.',
        'status': 'Active'
      },
      {
        'title': 'First-time add-on',
        'desc': 'Use comfort+ for free on your next request.',
        'status': 'Used'
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Offers & promotions')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          final isActive = offer['status'] == 'Active';
          return GlassCard(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(offer['title']!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(offer['status']!),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(offer['desc']!),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text('Activate'),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (index * 80).ms);
        },
      ),
    );
  }
}
