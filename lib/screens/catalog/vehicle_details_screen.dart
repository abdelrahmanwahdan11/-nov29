
import 'package:flutter/material.dart';

import '../../data/models/vehicle.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';

class VehicleDetailsScreen extends StatefulWidget {
  const VehicleDetailsScreen({super.key, required this.vehicle});
  final Vehicle vehicle;

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  bool flipped = false;

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicle;
    return Scaffold(
      appBar: AppBar(title: Text('${vehicle.brand} ${vehicle.model}')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () => setState(() => flipped = !flipped),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: flipped
                  ? GlassCard(
                      key: const ValueKey('back'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Specs',
                              style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 12),
                          Text(vehicle.descriptionLong),
                        ],
                      ),
                    )
                  : ClipRRect(
                      key: const ValueKey('front'),
                      borderRadius: BorderRadius.circular(32),
                      child: Image.network(vehicle.imageUrl, fit: BoxFit.cover),
                    ),
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Power ${vehicle.power} · Range ${vehicle.rangeKm} km'),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Choose for trip'),
                    AIInfoButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
