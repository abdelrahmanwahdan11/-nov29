import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../widgets/ai_info_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../more/route_insights_screen.dart';

class TripPlanningScreen extends StatefulWidget {
  const TripPlanningScreen({super.key});

  @override
  State<TripPlanningScreen> createState() => _TripPlanningScreenState();
}

class _TripPlanningScreenState extends State<TripPlanningScreen> {
  final pickupController = TextEditingController(text: 'Downtown HQ');
  final dropoffController = TextEditingController(text: 'Airport T3');
  final notesController = TextEditingController();
  final slots = const ['Now', '15 min', '45 min', 'Tonight'];
  int selectedSlot = 1;
  int selectedCard = 0;

  @override
  void dispose() {
    pickupController.dispose();
    dropoffController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Trip planning')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                GlassCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Expanded(
                            child: Text('Where should NexRide pick you up?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          AIInfoButton(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: pickupController,
                        decoration: const InputDecoration(labelText: 'Pickup'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: dropoffController,
                        decoration: const InputDecoration(labelText: 'Dropoff'),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: notesController,
                        decoration: const InputDecoration(
                            labelText: 'Notes to driver (optional)'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Stack(
                    children: [
                      Image.network(
                        'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=80',
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ).animate().fadeIn(),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: GlassCard(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            children: const [
                              Icon(Icons.directions_car, size: 16),
                              SizedBox(width: 6),
                              Text('Static preview map'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text('Departure window', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: List.generate(
                    slots.length,
                    (index) => ChoiceChip(
                      label: Text(slots[index]),
                      selected: selectedSlot == index,
                      onSelected: (_) => setState(() => selectedSlot = index),
                    ),
                  ),
                ).animate().fadeIn(),
                const SizedBox(height: 20),
                Text('AI cues', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _aiCards.length,
                    itemBuilder: (context, index) {
                      final card = _aiCards[index];
                      final selected = selectedCard == index;
                      return GestureDetector(
                        onTap: () => setState(() => selectedCard = index),
                        child: GlassCard(
                          margin: EdgeInsets.only(right: index == _aiCards.length - 1 ? 0 : 12),
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(card.icon,
                                    color: selected
                                        ? theme.colorScheme.primary
                                        : Colors.white70),
                                const SizedBox(height: 12),
                                Text(card.title,
                                    style: theme.textTheme.titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                Text(card.subtitle,
                                    style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .slideX(begin: 0.1 * index)
                            .scale(begin: selected ? 1.02 : 1.0),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pulse forecasts',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const RouteInsightsScreen()),
                      ),
                      child: const Text('View more'),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                ...pulseForecasts.take(2).map((forecast) {
                  return GlassCard(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                forecast.title,
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(forecast.timeframe),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(forecast.summary),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.route, size: 18, color: theme.colorScheme.primary),
                            const SizedBox(width: 8),
                            Text('${forecast.delayMinutes >= 0 ? '+' : ''}${forecast.delayMinutes} min'),
                            const Spacer(),
                            Text('${(forecast.confidence * 100).round()}% conf.',
                                style: theme.textTheme.labelMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final tag in forecast.tags)
                              Chip(label: Text(tag))
                                  .animate()
                                  .scale(duration: 200.ms, curve: Curves.easeOut),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1);
                }).toList(),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: const [
                BoxShadow(blurRadius: 32, color: Colors.black26),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.attach_money_rounded),
                    SizedBox(width: 8),
                    Text('Estimated 34 credits · 24 km'),
                  ],
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: 'Request car',
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Trip requested'),
                      content: const Text(
                          'NexRide is simulating your request locally – once AI dispatch goes live, this will connect instantly.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Okay'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiCardData {
  const _AiCardData(this.title, this.subtitle, this.icon);
  final String title;
  final String subtitle;
  final IconData icon;
}

const _aiCards = [
  _AiCardData('Eco ride', 'Car waits + optimises battery usage.', Icons.bolt),
  _AiCardData('Comfort cabin', 'Lights + playlist for your focus mode.', Icons.music_note),
  _AiCardData('Shared route', 'Pick a friend midway without detours.', Icons.group_add),
];
