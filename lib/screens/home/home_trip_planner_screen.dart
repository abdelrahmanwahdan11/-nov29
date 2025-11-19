
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/trip.dart';
import '../../data/models/vehicle.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/skeleton_loader.dart';
import '../../widgets/stat_pill.dart';
import '../../widgets/trip_card.dart';
import '../more/charge_radar_screen.dart';
import '../more/event_spotlights_screen.dart';
import '../trip/trip_planning_screen.dart';

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
    final isLoading = controllers.trip.historyLoading;
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
          _statusTicker(context, controllers),
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
          const SizedBox(height: 24),
          _citySignalsSection(context),
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
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Open trip planner',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TripPlanningScreen()),
            ),
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
                        tab: _,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _citySignalsSection(BuildContext context) {
    if (eventSpotlights.isEmpty || chargeSpots.isEmpty) {
      return const SizedBox.shrink();
    }
    final event = eventSpotlights.first;
    final spot = chargeSpots.first;
    final isWide = MediaQuery.of(context).size.width > 640;
    final cards = <Widget>[
      _SignalCard(
        title: event.title,
        subtitle: event.highlight,
        meta: '${event.venue} · ${event.chips.first}',
        imageUrl: event.heroImageUrl,
        icon: Icons.event,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const EventSpotlightsScreen()),
        ),
      ),
      _SignalCard(
        title: spot.name,
        subtitle: spot.status,
        meta: '${spot.availablePods}/${spot.totalPods} pods free',
        imageUrl: spot.imageUrl,
        icon: Icons.ev_station,
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ChargeRadarScreen()),
        ),
      ),
    ];
    final list = isWide
        ? Row(
            children: [
              for (int i = 0; i < cards.length; i++) ...[
                Expanded(child: cards[i]),
                if (i != cards.length - 1) const SizedBox(width: 12),
              ],
            ],
          )
        : Column(
            children: [
              for (int i = 0; i < cards.length; i++) ...[
                cards[i],
                if (i != cards.length - 1) const SizedBox(height: 12),
              ],
            ],
          );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('City signals',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold))
            .animate()
            .fadeIn(),
        const SizedBox(height: 12),
        list,
      ],
    );
  }

  Widget _tripList({
    required bool isLoading,
    required ControllerScope controllers,
    required String tab,
  }) {
    if (isLoading) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        itemBuilder: (_, __) => const SkeletonLoader(height: 100),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 2,
      );
    }
    final now = DateTime.now();
    Iterable<Trip> trips = controllers.trip.historyItems;
    if (tab == 'Upcoming') {
      trips = trips.where((trip) => trip.scheduledTime.isAfter(now));
    } else if (tab == 'Active') {
      trips = trips.where((trip) =>
          trip.status == 'on_the_way' ||
          trip.status == 'ready_at_pickup' ||
          trip.status == 'in_progress');
    } else {
      trips = trips.where((trip) => trip.scheduledTime.isBefore(now));
    }
    final items = trips.take(4).toList();
    if (items.isEmpty) {
      return _emptyTimelineState(tab);
    }
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemBuilder: (_, index) =>
          TripCard(trip: items[index]).animate().fadeIn().slideX(begin: 0.1),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: items.length,
    );
  }

  Widget _emptyTimelineState(String tab) {
    return Align(
      alignment: Alignment.topCenter,
      child: GlassCard(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome_mosaic_outlined, size: 32),
            const SizedBox(height: 8),
            Text('No $tab trips yet',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            const Text('Plan a new route to populate this lane.'),
          ],
        ),
      ).animate().fadeIn(),
    );
  }

  Widget _statusTicker(BuildContext context, ControllerScope controllers) {
    const order = [
      'requested',
      'on_the_way',
      'ready_at_pickup',
      'in_progress',
      'completed',
    ];
    final copy = {
      'requested': 'Matching your cabin & driver',
      'on_the_way': 'Vehicle is gliding toward pickup',
      'ready_at_pickup': 'Car waiting · unlock when ready',
      'in_progress': 'Enjoying the ride',
      'completed': 'Trip archived • share recap',
    };
    return ValueListenableBuilder<String>(
      valueListenable: controllers.trip.statusNotifier,
      builder: (context, status, _) {
        final idx = order.indexOf(status).clamp(0, order.length - 1);
        final ratio = idx / (order.length - 1);
        return ValueListenableBuilder<Duration>(
          valueListenable: controllers.trip.countdownNotifier,
          builder: (context, countdown, __) {
            final minutes = countdown.inMinutes.remainder(60).toString().padLeft(2, '0');
            final seconds = countdown.inSeconds.remainder(60).toString().padLeft(2, '0');
            return GlassCard(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.podcasts, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 10),
                      Text(status.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, letterSpacing: 1.1)),
                      const Spacer(),
                      Text('$minutes:$seconds'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(copy[status] ?? 'Monitoring trip',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(value: ratio, minHeight: 6)
                        .animate()
                        .slideX(begin: -0.2),
                  ),
                ],
              ),
            ).animate().shimmer(delay: 200.ms, duration: 1400.ms);
          },
        );
      },
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

class _SignalCard extends StatelessWidget {
  const _SignalCard({
    required this.title,
    required this.subtitle,
    required this.meta,
    required this.imageUrl,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String meta;
  final String imageUrl;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                imageUrl,
                height: 110,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ).animate().fadeIn(),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(icon, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(meta,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ).animate().slideY(begin: 0.15).fadeIn(),
    );
  }
}

