
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/stat_pill.dart';
import '../account/favorites_screen.dart';
import '../account/offers_screen.dart';
import '../account/trips_history_screen.dart';
import '../account/wallet_screen.dart';
import '../more/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = ControllerScope.of(context).auth;
    final user = auth.user;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(user?.avatarUrl ?? ''),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user?.name ?? 'Guest',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      Text(user?.email ?? 'guest@nexride.ai'),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  ),
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatPill(label: 'Rides', value: '${user?.ridesCount ?? 0}', icon: Icons.route),
              StatPill(label: 'Km', value: '${user?.kilometers ?? 0}', icon: Icons.timeline),
              StatPill(label: 'Hours', value: '${user?.hours ?? 0}', icon: Icons.timelapse),
            ],
          ),
          const SizedBox(height: 24),
          _ProfileTile(
            title: 'Trips history',
            subtitle: 'Timeline, receipts, share links',
            icon: Icons.history,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const TripsHistoryScreen()),
            ),
          ),
          _ProfileTile(
            title: 'Wallet',
            subtitle: 'Payment methods & credits',
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WalletScreen()),
            ),
          ),
          _ProfileTile(
            title: 'Offers & rewards',
            subtitle: 'Coupons & loyalty tiers',
            icon: Icons.local_activity_outlined,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const OffersScreen()),
            ),
          ),
          _ProfileTile(
            title: 'Favorites',
            subtitle: 'Saved vehicles & places',
            icon: Icons.favorite_outline,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon),
          title: Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
