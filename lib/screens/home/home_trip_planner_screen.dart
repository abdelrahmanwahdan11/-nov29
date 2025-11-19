
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../data/models/vehicle.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/skeleton_loader.dart';
import '../../widgets/stat_pill.dart';
import '../../widgets/trip_card.dart';

class HomeTripPlannerScreen extends StatefulWidget {
  const HomeTripPlannerScreen({super.key});

  @override
  State<HomeTripPlannerScreen> createState() => _HomeTripPlannerScreenState();
}

class _HomeTripPlannerScreenState extends State<HomeTripPlannerScreen> {
  final _quickActions = const ['Home', 'Company', 'Studio', 'Airport'];
  final PageController _heroController =
      PageController(viewportFraction: 0.88, keepPage: true);

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllers = ControllerScope.of(context);
    final trip = controllers.trip.activeTrip;
    final isLoading = controllers.catalog.isLoading;
    return RefreshIndicator(
      onRefresh: controllers.catalog.refresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 140),
        children: [
          _header(context, controllers),
          const SizedBox(height: 18),
          _plannerCard(context),
          const SizedBox(height: 18),
          _quickActionsRow(context),
          const SizedBox(height: 18),
          if (trip != null) ...[
            Text('Live trip',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold))
                .animate()
                .fadeIn(),
            const SizedBox(height: 8),
            TripCard(trip: trip),
            const SizedBox(height: 18),
          ],
          _heroVehicles(context, controllers),
          const SizedBox(height: 18),
          _statsRow(context, controllers),
          const SizedBox(height: 18),
          _timelineTabs(isLoading, controllers),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, ControllerScope controllers) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey ${controllers.auth.user?.name ?? 'traveler'}',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700))
                .animate()
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.2),
              const SizedBox(height: 4),
              Text('Miami · Available',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(controllers.auth.user?.avatarUrl ?? ''),
        ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
      ],
    );
  }

  Widget _plannerCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Where are we heading?',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    SizedBox(height: 6),
                    _LocationRow(label: 'Pickup', value: 'Downtown HQ'),
                    Divider(),
                    _LocationRow(label: 'Dropoff', value: 'Airport T3'),
                  ],
                ),
              ),
              const AIInfoButton(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.timer_outlined, color: Colors.white70),
              SizedBox(width: 8),
              Text('Car waits 5 min + 2 min walk'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _quickActionsRow(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _quickActions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white.withOpacity(0.08),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Icon(Icons.add_location_alt_rounded,
                    size: 18, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                Text(_quickActions[index]),
              ],
            ),
          ).animate().fadeIn(delay: (index * 80).ms).scale(begin: 0.9);
        },
      ),
    );
  }

  Widget _heroVehicles(BuildContext context, ControllerScope controllers) {
    final vehicles = controllers.catalog.items;
    final List<Vehicle> content = vehicles.isEmpty
        ? const []
        : vehicles.take(3).toList(growable: false);
    return SizedBox(
      height: 230,
      child: PageView.builder(
        controller: _heroController,
        itemCount: content.isEmpty ? 1 : content.length,
        itemBuilder: (context, index) {
          final vehicle = content.isEmpty ? null : content[index];
          return Padding(
            padding: EdgeInsets.only(right: index == content.length - 1 ? 0 : 12),
            child: GlassCard(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(vehicle != null
                            ? '${vehicle.brand} ${vehicle.model}'
                            : 'Loading fleet'),
                        const SizedBox(height: 8),
                        Text(vehicle?.descriptionShort ??
                            'We are preparing curated rides for you.'),
                        const Spacer(),
                        Row(
                          children: const [
                            Icon(Icons.bolt, size: 16),
                            SizedBox(width: 4),
                            Text('AI comfort mode'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: vehicle == null
                        ? const SkeletonLoader(height: 160)
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(vehicle.imageUrl,
                                fit: BoxFit.cover),
                          ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.2, duration: 450.ms).fadeIn(),
          );
        },
      ),
    );
  }

  Widget _statsRow(BuildContext context, ControllerScope controllers) {
    final user = controllers.auth.user;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        StatPill(label: 'Rides', value: '${user?.ridesCount ?? 0}', icon: Icons.route),
        StatPill(label: 'Km', value: '${user?.kilometers ?? 0}', icon: Icons.speed),
        StatPill(label: 'Hours', value: '${user?.hours ?? 0}', icon: Icons.timelapse),
      ],
    );
  }

  Widget _timelineTabs(bool isLoading, ControllerScope controllers) {
    final tabs = ['Upcoming', 'Active', 'Past'];
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          TabBar(tabs: tabs.map((label) => Tab(text: label)).toList()),
          SizedBox(
            height: 250,
            child: TabBarView(
              children: tabs
                  .map((_) => _tripList(
                        isLoading: isLoading,
                        controllers: controllers,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tripList({required bool isLoading, required ControllerScope controllers}) {
    if (isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemBuilder: (_, __) => const SkeletonLoader(height: 100),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 2,
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (_, index) => TripCard(trip: controllers.trip.activeTrip!),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: 2,
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}

