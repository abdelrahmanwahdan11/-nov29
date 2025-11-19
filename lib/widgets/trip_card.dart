
import 'package:flutter/material.dart';

import '../data/models/trip.dart';
import 'glass_card.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${trip.pickupLocation} → ${trip.dropoffLocation}',
              style: theme.textTheme.titleMedium),
          const SizedBox(height: 6),
          Text('${trip.distanceKm} km · ${trip.price} credits',
              style: theme.textTheme.bodyMedium),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: trip.status == 'completed' ? 1 : 0.5,
          ),
        ],
      ),
    );
  }
}
