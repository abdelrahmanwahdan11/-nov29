
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/models/vehicle.dart';
import 'glass_card.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.vehicle,
    this.onTap,
    this.onToggleCompare,
    this.selectedForCompare = false,
  });

  final Vehicle vehicle;
  final VoidCallback? onTap;
  final VoidCallback? onToggleCompare;
  final bool selectedForCompare;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${vehicle.brand} ${vehicle.model}',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vehicle.descriptionShort,
                        style: textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onToggleCompare,
                  icon: Icon(
                    selectedForCompare
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: selectedForCompare ? color : Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  vehicle.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ).animate().scale(curve: Curves.easeOutBack, duration: 450.ms),
            const SizedBox(height: 12),
            Row(
              children: [
                _chip('${vehicle.seats} seats'),
                const SizedBox(width: 6),
                _chip('${vehicle.rangeKm} km'),
                const SizedBox(width: 6),
                _chip('${vehicle.basePrice}/km'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
