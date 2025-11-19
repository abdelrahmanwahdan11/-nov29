import 'package:flutter/material.dart';

class CabinMood {
  const CabinMood({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.gradient,
    required this.badge,
    required this.focusScore,
    required this.energyScore,
    required this.rituals,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final List<Color> gradient;
  final String badge;
  final double focusScore;
  final double energyScore;
  final List<String> rituals;
}
