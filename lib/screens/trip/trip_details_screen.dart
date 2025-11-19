import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = ControllerScope.of(context).trip.activeTrip;
    return Scaffold(
      appBar: AppBar(title: const Text('Trip details')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          if (trip != null)
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${trip.pickupLocation} → ${trip.dropoffLocation}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text('${trip.distanceKm} km · ${trip.price} credits'),
                  const SizedBox(height: 6),
                  Text('Shared link: ${trip.shareLink}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white70)),
                ],
              ),
            ),
          const SizedBox(height: 24),
          Text('Timeline',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold))
              .animate()
              .fadeIn(),
          const SizedBox(height: 12),
          ..._timeline.map(
            (entry) => GlassCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(entry.time,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                      if (entry != _timeline.last)
                        Container(
                          width: 2,
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.3),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(entry.subtitle,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: const [
                Icon(Icons.speed_rounded),
                SizedBox(width: 12),
                Expanded(
                  child: Text('Distance 24.3 km · Exit at Downtown Miami'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: const [
                Icon(Icons.credit_card),
                SizedBox(width: 12),
                Expanded(
                  child: Text('Paid with Nex Wallet · **** 2871'),
                ),
                Text('42.70'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Edit trip',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Share trip'),
          ),
        ],
      ),
    );
  }
}

class _TimelineEntry {
  const _TimelineEntry({
    required this.time,
    required this.title,
    required this.subtitle,
  });

  final String time;
  final String title;
  final String subtitle;
}

const _timeline = [
  _TimelineEntry(
    time: '09:10',
    title: 'Near to dropoff',
    subtitle: 'Downtown Miami · 5 min walk to lobby',
  ),
  _TimelineEntry(
    time: '08:35',
    title: 'Downtown departure',
    subtitle: 'Left the HQ campus with coffee ready',
  ),
  _TimelineEntry(
    time: '08:10',
    title: 'Little Havana pause',
    subtitle: 'AI recommended scenic detour for guest pickup',
  ),
  _TimelineEntry(
    time: '07:55',
    title: 'Boarding at Wynwood',
    subtitle: 'Driver confirmed via NexRide ID and shared AR directions',
  ),
];
