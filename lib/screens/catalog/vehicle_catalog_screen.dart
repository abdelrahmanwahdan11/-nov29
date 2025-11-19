
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/filter_chip_pill.dart';
import '../../widgets/skeleton_loader.dart';
import '../../widgets/vehicle_card.dart';

class VehicleCatalogScreen extends StatefulWidget {
  const VehicleCatalogScreen({super.key});

  @override
  State<VehicleCatalogScreen> createState() => _VehicleCatalogScreenState();
}

class _VehicleCatalogScreenState extends State<VehicleCatalogScreen> {
  final _categories = const ['All', 'Sedan', 'SUV', 'Sport', 'Electric'];

  @override
  Widget build(BuildContext context) {
    final catalog = ControllerScope.of(context).catalog;
    final filtered = catalog.filteredItems();
    return RefreshIndicator(
      onRefresh: catalog.refresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: [
          AppSearchBar(
            onChanged: (value) {
              setState(() => catalog.query = value);
            },
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 46,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, index) => FilterChipPill(
                label: _categories[index],
                selected: catalog.category == _categories[index],
                onTap: () => setState(() => catalog.category = _categories[index]),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (catalog.isLoading)
            Column(
              children: const [
                SkeletonLoader(height: 220),
                SizedBox(height: 12),
                SkeletonLoader(height: 220),
              ],
            )
          else
            ...filtered.map(
              (vehicle) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: VehicleCard(
                  vehicle: vehicle,
                  selectedForCompare: catalog.compareList.contains(vehicle),
                  onToggleCompare: () => setState(() => catalog.toggleCompare(vehicle)),
                ),
              ),
            ),
          if (catalog.isPaginating)
            const Padding(
              padding: EdgeInsets.all(12),
              child: SkeletonLoader(height: 180),
            )
          else
            TextButton(
              onPressed: catalog.loadMore,
              child: const Text('Load more vehicles'),
            ),
        ],
      ),
    );
  }
}
