
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/trip.dart';
import 'glass_card.dart';

class TripCard extends StatelessWidget {
  const TripCard({super.key, required this.trip});
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _statusColor(theme, trip.status);
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text('${trip.pickupLocation} → ${trip.dropoffLocation}',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  trip.status.replaceAll('_', ' ').toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(color: color),
                ),
              )
                  .animate()
                  .fadeIn(duration: 250.ms)
                  .slideY(begin: -0.2),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.ev_station, size: 18),
              const SizedBox(width: 6),
              Text('${trip.distanceKm.toStringAsFixed(1)} km'),
              const SizedBox(width: 12),
              const Icon(Icons.payments, size: 18),
              const SizedBox(width: 6),
              Text('${trip.price.toStringAsFixed(2)} credits'),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: trip.status == 'completed'
                  ? 1
                  : trip.status == 'ready_at_pickup'
                      ? 0.8
                      : 0.5,
              color: color,
              backgroundColor: Colors.white.withOpacity(0.08),
            ),
          ).animate().scaleX(begin: 0.2, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }

  Color _statusColor(ThemeData theme, String status) {
    switch (status) {
      case 'completed':
        return Colors.greenAccent;
      case 'cancelled':
        return theme.colorScheme.error;
      case 'on_the_way':
        return theme.colorScheme.primary;
      default:
        return theme.colorScheme.secondary;
    }
  }
}
