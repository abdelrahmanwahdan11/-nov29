import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final methods = [
      {'name': 'Visa **** 3944', 'type': 'card'},
      {'name': 'Payoneer business', 'type': 'wallet'},
      {'name': 'Cash', 'type': 'cash'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet & payments')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Balance', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Text('428.65 credits',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                PrimaryButton(label: 'Add credits', onPressed: () {}),
              ],
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 24),
          Text('Payment methods',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...methods.map(
            (method) => GlassCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    method['type'] == 'card'
                        ? Icons.credit_card
                        : method['type'] == 'wallet'
                            ? Icons.account_balance_wallet_outlined
                            : Icons.money,
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(method['name']!)),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ).animate().slideY(begin: 0.2).fadeIn(),
          ),
        ],
      ),
    );
  }
}
