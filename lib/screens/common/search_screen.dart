
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/glass_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerScope.of(context).search;
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              AppSearchBar(
                onChanged: controller.search,
              ),
              const SizedBox(height: 24),
              if (!controller.hasResults) ...[
                Text('Suggested queries',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold))
                    .animate()
                    .fadeIn(),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: controller.suggestions
                      .map(
                        (suggestion) => ChoiceChip(
                          label: Text(suggestion),
                          selected: false,
                          onSelected: (_) => controller.search(suggestion),
                        ),
                      )
                      .toList(),
                ),
                if (controller.recent.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text('Recent', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ...controller.recent.map(
                    (query) => ListTile(
                      leading: const Icon(Icons.history),
                      title: Text(query),
                      onTap: () => controller.search(query),
                    ),
                  ),
                ],
              ] else ...[
                if (controller.vehicleResults.isNotEmpty) ...[
                  Text('Vehicles',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...controller.vehicleResults.map(
                    (vehicle) => GlassCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${vehicle.brand} ${vehicle.model}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16)),
                                const SizedBox(height: 4),
                                Text('${vehicle.category} · ${vehicle.rangeKm} km range'),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ).animate().fadeIn(),
                  ),
                  const SizedBox(height: 24),
                ],
                if (controller.tripResults.isNotEmpty) ...[
                  Text('Trips', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ...controller.tripResults.map(
                    (trip) => GlassCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.route),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${trip.pickupLocation} → ${trip.dropoffLocation}'),
                                Text('${trip.distanceKm} km · ${trip.price} credits',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.white70)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (controller.locationResults.isNotEmpty) ...[
                  Text('Locations',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...controller.locationResults.map(
                    (place) => ListTile(
                      leading: const Icon(Icons.push_pin_outlined),
                      title: Text(place),
                      trailing: const Icon(Icons.north_east),
                    ),
                  ),
                ],
              ],
            ],
          );
        },
      ),
    );
  }
}
