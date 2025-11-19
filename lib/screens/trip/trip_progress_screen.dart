import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class TripProgressScreen extends StatelessWidget {
  const TripProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerScope.of(context).trip;
    final trip = controller.activeTrip;
    return Scaffold(
      appBar: AppBar(title: const Text('Trip progress')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: SizedBox(
                  height: 220,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        trip?.mapImageUrl ??
                            'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment(
                            -0.6 + (controller.statusNotifier.value == 'in_progress' ? 0.8 : 0),
                            0.3,
                          ),
                          child: GlassCard(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.directions_car, size: 16),
                                SizedBox(width: 8),
                                Text('EV en route'),
                              ],
                            ),
                          ),
                        ).animate().moveX(duration: 600.ms),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<String>(
                valueListenable: controller.statusNotifier,
                builder: (context, status, _) {
                  return GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status: ${status.replaceAll('_', ' ')}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text(
                            'Share this screen to let friends track your arrival.'),
                      ],
                    ),
                  ).animate().fadeIn();
                },
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder<Duration>(
                valueListenable: controller.countdownNotifier,
                builder: (context, duration, _) {
                  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
                  final hours = duration.inHours.toString().padLeft(2, '0');
                  return GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        const Icon(Icons.timer_rounded),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text('Car waits 5 min · ETA $hours:$minutes'),
                        ),
                        const Icon(Icons.notifications_active_rounded),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              if (trip != null)
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(trip.mapImageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${trip.pickupLocation} → ${trip.dropoffLocation}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('${trip.distanceKm} km · ${trip.price} credits'),
                            const SizedBox(height: 4),
                            const Text('Plate: NXR-204 · Seats 4'),
                          ],
                        ),
                      ),
                      const Icon(Icons.key_rounded),
                    ],
                  ),
                ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Start ride',
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Get help'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Share trip'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
