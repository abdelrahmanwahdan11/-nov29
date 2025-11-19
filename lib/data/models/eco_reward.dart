import 'package:flutter/material.dart';

class EcoReward {
  const EcoReward({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.streak,
    required this.reward,
    required this.imageUrl,
    required this.accent,
  });

  final String id;
  final String title;
  final String description;
  final double progress;
  final int streak;
  final String reward;
  final String imageUrl;
  final Color accent;
}
