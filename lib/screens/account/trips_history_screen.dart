import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/skeleton_loader.dart';
import '../../widgets/trip_card.dart';

class TripsHistoryScreen extends StatelessWidget {
  const TripsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = ControllerScope.of(context).trip;
    final tabs = const ['All', 'Completed', 'Cancelled'];
    return Scaffold(
      appBar: AppBar(title: const Text('Trips history')),
      body: AnimatedBuilder(
        animation: trip,
        builder: (context, _) {
          final items = trip.historyItems;
          return DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                  onChanged: trip.updateHistoryQuery,
                  decoration: InputDecoration(
                    hintText: 'Search by pickup or dropoff',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              TabBar(
                tabs: tabs.map((label) => Tab(text: label)).toList(),
                onTap: (index) => trip.updateHistoryFilter(tabs[index]),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: trip.refreshHistory,
                  child: trip.historyLoading
                      ? ListView.separated(
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (_, __) => const SkeletonLoader(height: 120),
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemCount: 3,
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                          itemCount:
                              items.length + (trip.canLoadMoreHistory ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= items.length) {
                              trip.loadMoreHistory();
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: SkeletonLoader(height: 100),
                              );
                            }
                            final record = items[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    record.scheduledTime
                                        .toLocal()
                                        .toString()
                                        .substring(0, 16),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(color: Colors.white70),
                                  ),
                                  const SizedBox(height: 8),
                                  TripCard(trip: record),
                                  const SizedBox(height: 8),
                                  GlassCard(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.share_rounded, size: 18),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            record.shareLink,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text('Share'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ).animate().fadeIn(duration: 300.ms),
                            );
                          },
                        ),
                ),
              ),
              ],
            ),
          );
        },
      ),
    );
  }
}
