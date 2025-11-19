import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/mock/mock_data.dart';
import '../../data/models/community_challenge.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class CommunityChallengesScreen extends StatelessWidget {
  const CommunityChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community challenges')),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
        itemCount: communityChallenges.length,
        itemBuilder: (context, index) {
          final challenge = communityChallenges[index];
          return _ChallengeCard(challenge: challenge, index: index);
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: PrimaryButton(
          label: 'Create crew rally',
          onPressed: () {},
        ).animate().slideY(begin: 0.2).fadeIn(),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge, required this.index});

  final CommunityChallenge challenge;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ratio = challenge.completionRatio;
    final percent = (ratio * 100).round();
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor:
                    theme.colorScheme.primary.withOpacity(0.08 * (index + 1)),
                child: Icon(Icons.auto_awesome_rounded,
                    color: theme.colorScheme.primary),
              ).animate().scale(delay: (index * 80).ms),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(challenge.title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    Text(challenge.tagline,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: theme.hintColor)),
                  ],
                ),
              ),
              Text('$percent%',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(challenge.description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 8,
            ).animate().slideX(begin: -0.2),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${challenge.progress.toStringAsFixed(0)} / '
                  '${challenge.target.toStringAsFixed(0)}'),
              Text(challenge.reward,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.secondary)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.groups_3_outlined,
                  color: theme.colorScheme.primary, size: 18),
              const SizedBox(width: 6),
              Text('Invite crew', style: theme.textTheme.labelLarge),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_outlined),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 60).ms);
  }
}
