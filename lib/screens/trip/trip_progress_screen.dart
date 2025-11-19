
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';

class TripProgressScreen extends StatelessWidget {
  const TripProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = ControllerScope.of(context).trip;
    return Scaffold(
      appBar: AppBar(title: const Text('Trip progress')),
      body: ValueListenableBuilder<String>(
        valueListenable: trip.statusNotifier,
        builder: (context, status, _) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Status: $status'),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(
                    trip.activeTrip?.mapImageUrl ??
                        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
