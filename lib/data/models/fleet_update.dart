import 'package:flutter/material.dart';

class FleetUpdate {
  const FleetUpdate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.eta,
    required this.chips,
    required this.gradient,
  });

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String status;
  final String eta;
  final List<String> chips;
  final List<Color> gradient;
}
