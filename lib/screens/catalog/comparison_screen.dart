
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../data/models/vehicle.dart';
import '../../widgets/glass_card.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final catalog = ControllerScope.of(context).catalog;
    final vehicles = catalog.compareList;
    final metrics = [
      _ComparisonMetric('Seats', (Vehicle v) => v.seats.toDouble()),
      _ComparisonMetric('Power', (Vehicle v) =>
          double.tryParse(v.power.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0,
          higherIsBetter: true,
          unit: 'kW'),
      _ComparisonMetric('Range', (Vehicle v) => v.rangeKm,
          higherIsBetter: true, unit: 'km'),
      _ComparisonMetric('Base price', (Vehicle v) => v.basePrice,
          higherIsBetter: false, unit: 'cr'),
      _ComparisonMetric('Rating', (Vehicle v) => v.rating,
          higherIsBetter: true),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Compare vehicles')),
      body: vehicles.length < 2
          ? const Center(child: Text('Select at least two vehicles.'))
          : ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: vehicles
                      .map(
                        (vehicle) => GlassCard(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(vehicle.imageUrl),
                                radius: 26,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${vehicle.brand} ${vehicle.model}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  Text('${vehicle.basePrice} cr/km'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 24),
                ...metrics.map(
                  (metric) => _buildMetricRow(context, metric, vehicles),
                ),
              ],
            ),
    );
  }

  Widget _buildMetricRow(
      BuildContext context, _ComparisonMetric metric, List<Vehicle> vehicles) {
    final values = vehicles.map(metric.selector).toList();
    final target = metric.higherIsBetter
        ? values.reduce((a, b) => a > b ? a : b)
        : values.reduce((a, b) => a < b ? a : b);
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(metric.label,
              style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(
            children: vehicles.asMap().entries.map((entry) {
              final value = values[entry.key];
              final isBest = value == target;
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      metric.displayValue(value),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isBest
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                      ),
                    ),
                    if (isBest)
                      const Icon(Icons.emoji_events_rounded,
                          size: 18, color: Colors.amber),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ComparisonMetric {
  _ComparisonMetric(this.label, this.selector,
      {this.higherIsBetter = true, this.unit});

  final String label;
  final double Function(Vehicle vehicle) selector;
  final bool higherIsBetter;
  final String? unit;

  String displayValue(double value) {
    final formatted = value.toStringAsFixed(1);
    return unit == null ? formatted : '$formatted $unit';
  }
}
