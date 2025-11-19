
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';

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
            ListTile(
              title: Text('${trip.pickupLocation} → ${trip.dropoffLocation}'),
              subtitle: Text('${trip.distanceKm} km · ${trip.price} credits'),
            ),
          const ListTile(
            title: Text('Timeline'),
            subtitle: Text('Downtown - Little Havana - Brickell'),
          ),
        ],
      ),
    );
  }
}
