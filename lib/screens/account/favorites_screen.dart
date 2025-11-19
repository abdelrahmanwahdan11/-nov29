import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/vehicle_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    final catalog = scope.catalog;
    final user = scope.auth.user;
    final favoriteVehicles = catalog.items
        .where((vehicle) => user?.favoriteVehiclesIds.contains(vehicle.id) ?? false)
        .toList();
    final savedPlaces = const [
      {'name': 'Home Loft', 'address': '23 Ocean Dr'},
      {'name': 'HQ', 'address': '91 Innovation Ave'},
      {'name': 'Airport gate', 'address': 'Terminal 3'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: RefreshIndicator(
        onRefresh: () async {
          await catalog.refresh();
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Vehicles',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (favoriteVehicles.isEmpty)
              const Text('No favorites yet, tap the heart icon inside catalog.')
                  .animate()
                  .fadeIn()
            else
              ...favoriteVehicles.map(
                (vehicle) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: VehicleCard(vehicle: vehicle),
                ),
              ),
            const SizedBox(height: 24),
            Text('Saved places',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...savedPlaces.map(
              (place) => GlassCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.push_pin, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(place['name']!),
                          Text(place['address']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ],
                ),
              ).animate().slideX(begin: 0.2).fadeIn(),
            ),
          ],
        ),
      ),
    );
  }
}
