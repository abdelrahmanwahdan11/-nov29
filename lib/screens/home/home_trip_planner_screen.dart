
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/skeleton_loader.dart';
import '../../widgets/trip_card.dart';

class HomeTripPlannerScreen extends StatefulWidget {
  const HomeTripPlannerScreen({super.key});

  @override
  State<HomeTripPlannerScreen> createState() => _HomeTripPlannerScreenState();
}

class _HomeTripPlannerScreenState extends State<HomeTripPlannerScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controllers = ControllerScope.of(context);
    final trip = controllers.trip.activeTrip;
    final isLoading = controllers.catalog.isLoading;
    return RefreshIndicator(
      onRefresh: controllers.catalog.refresh,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hey ${controllers.auth.user?.name ?? 'traveler'}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('Miami · Available',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              CircleAvatar(
                radius: 26,
                backgroundImage:
                    NetworkImage(controllers.auth.user?.avatarUrl ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Where are we heading?',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                SizedBox(height: 8),
                _LocationRow(label: 'Pickup', value: 'Downtown HQ'),
                Divider(),
                _LocationRow(label: 'Dropoff', value: 'Airport T3'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (trip != null)
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Current trip',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  TripCard(trip: trip),
                ],
              ),
            ),
          const SizedBox(height: 20),
          GlassCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Halo X AI Edition',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Car on the way · 3 min'),
                    ],
                  ),
                ),
                const AIInfoButton(),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Active'),
                    Tab(text: 'Past'),
                  ],
                ),
                SizedBox(
                  height: 220,
                  child: TabBarView(
                    children: [
                      _tripList(isLoading: isLoading, controllers: controllers),
                      _tripList(isLoading: isLoading, controllers: controllers),
                      _tripList(isLoading: isLoading, controllers: controllers),
                    ],
                  ),
                ),
              ],
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
