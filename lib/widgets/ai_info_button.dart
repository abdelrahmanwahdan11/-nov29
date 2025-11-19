
import 'package:flutter/material.dart';

class AIInfoButton extends StatelessWidget {
  const AIInfoButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => _showDefaultSheet(context),
      icon: const Icon(Icons.auto_awesome),
    );
  }

  void _showDefaultSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Nex-AI', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
              'In future versions, AI will analyze your preferences and suggest the best vehicle and time for your trip.',
            ),
          ],
        ),
      ),
    );
  }
}
