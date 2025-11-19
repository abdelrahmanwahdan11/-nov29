import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/charge_spot.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class ChargeRadarScreen extends StatefulWidget {
  const ChargeRadarScreen({super.key});

  @override
  State<ChargeRadarScreen> createState() => _ChargeRadarScreenState();
}

class _ChargeRadarScreenState extends State<ChargeRadarScreen> {
  late String _activeEnergy;
  bool _instantOnly = false;

  @override
  void initState() {
    super.initState();
    _activeEnergy = 'All';
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filters = <String>{'All', ...chargeSpots.map((spot) => spot.energyType)}.toList();
    filters.sort();
    final filtered = chargeSpots.where((spot) {
      final matchesEnergy = _activeEnergy == 'All' || spot.energyType == _activeEnergy;
      final matchesInstant = !_instantOnly || spot.waitMinutes <= 5;
      return matchesEnergy && matchesInstant;
    }).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Charge radar')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _hero(context),
            const SizedBox(height: 20),
            Text('Energy lanes',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filters
                  .map(
                    (label) => FilterChip(
                      label: Text(label),
                      selected: _activeEnergy == label,
                      onSelected: (_) => setState(() => _activeEnergy = label),
                    ),
                  )
                  .toList(),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              value: _instantOnly,
              title: const Text('Instant pods only (≤5 min wait)'),
              onChanged: (value) => setState(() => _instantOnly = value),
            ),
            const SizedBox(height: 12),
            ...filtered.asMap().entries.map(
              (entry) => _ChargeSpotCard(spot: entry.value)
                  .animate(delay: (entry.key * 80).ms)
                  .fadeIn()
                  .slideX(begin: 0.1),
            ),
            if (filtered.isEmpty)
              GlassCard(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: const [
                    Icon(Icons.hourglass_empty),
                    SizedBox(height: 12),
                    Text('No pods match this filter right now.'),
                  ],
                ),
              ).animate().shake(),
          ],
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return GlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Image.network(
              'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1400&q=80',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ).animate().fadeIn().scale(begin: 0.95),
          const SizedBox(height: 16),
          Text('Live supply radar',
              style:
                  Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('AI keeps track of solar, tidal and grid boosts so you always dock at the fastest pod.'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'Plan smart charge',
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: primary.withOpacity(0.2),
                child: Icon(Icons.auto_awesome, color: primary),
              ).animate().shimmer(delay: 200.ms),
            ],
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}

class _ChargeSpotCard extends StatelessWidget {
  const _ChargeSpotCard({required this.spot});

  final ChargeSpot spot;

  @override
  Widget build(BuildContext context) {
    final percent = spot.availablePods / spot.totalPods;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  spot.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ).animate().fadeIn(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(spot.name,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                    Text(spot.neighborhood, style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 6),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(spot.status.toUpperCase(),
                            style: const TextStyle(fontSize: 11, letterSpacing: 1.1)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${spot.availablePods}/${spot.totalPods} pods free',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: LinearProgressIndicator(value: percent, minHeight: 6),
                    ).animate().slideX(begin: -0.2),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${spot.powerKw.toStringAsFixed(0)} kW',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: 300.ms,
                    child: Text(
                      'Wait ${spot.waitMinutes} min',
                      key: ValueKey(spot.waitMinutes),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _chip(Icons.bolt, spot.energyType, context),
              _chip(Icons.timer, spot.lastUpdated, context),
              ...spot.amenities.map((label) => _chip(Icons.blur_on, label, context)),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().scale(begin: 0.97);
  }

  Widget _chip(IconData icon, String label, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
