
import 'package:flutter/material.dart';

import '../../controllers/catalog_controller.dart';
import '../../controllers/controller_scope.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/filter_chip_pill.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/skeleton_loader.dart';
import '../../widgets/vehicle_card.dart';
import '../catalog/comparison_screen.dart';

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
    return AnimatedBuilder(
      animation: catalog,
      builder: (context, _) {
        final filtered = catalog.filteredItems();
        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: catalog.refresh,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 160),
                children: [
                  AppSearchBar(
                    onChanged: catalog.updateQuery,
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
                        onTap: () => catalog.updateCategory(_categories[index]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _filterWrap(context, catalog),
                  const SizedBox(height: 18),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: catalog.isLoading
                        ? Column(
                            key: const ValueKey('loading'),
                            children: const [
                              SkeletonLoader(height: 220),
                              SizedBox(height: 12),
                              SkeletonLoader(height: 220),
                            ],
                          )
                        : Column(
                            key: const ValueKey('list'),
                            children: filtered
                                .map(
                                  (vehicle) => Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16),
                                    child: VehicleCard(
                                      vehicle: vehicle,
                                      selectedForCompare: catalog.compareList
                                          .contains(vehicle),
                                      onToggleCompare: () =>
                                          catalog.toggleCompare(vehicle),
                                    ),
                                  ),
                                )
                                .toList(),
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
            ),
            if (catalog.compareList.length >= 2)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: PrimaryButton(
                  label:
                      'Compare ${catalog.compareList.length} selected vehicles',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ComparisonScreen()),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _filterWrap(BuildContext context, CatalogController catalog) {
    final priceOptions = [null, 12.0, 15.0, 20.0];
    final seatsOptions = [null, 2, 4, 6];
    final sortOptions = ['Recommended', 'Price', 'Range', 'Rating'];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ...priceOptions.map(
          (price) => ChoiceChip(
            label: Text(price == null ? 'Any price' : '< ${price.toStringAsFixed(0)} cr'),
            selected: catalog.maxPrice == price,
            onSelected: (_) => catalog.updateMaxPrice(price),
          ),
        ),
        ...seatsOptions.map(
          (seat) => ChoiceChip(
            label: Text(seat == null ? 'Any seats' : '${seat}+ seats'),
            selected: catalog.minSeats == seat,
            onSelected: (_) => catalog.updateMinSeats(seat),
          ),
        ),
        DropdownButton<String>(
          value: catalog.sort,
          underline: const SizedBox.shrink(),
          dropdownColor: Theme.of(context).cardColor,
          items: sortOptions
              .map((label) => DropdownMenuItem(
                    value: label,
                    child: Text('Sort: $label'),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) catalog.updateSort(value);
          },
        ),
      ],
    );
  }
}
