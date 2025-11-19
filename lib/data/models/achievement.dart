import 'package:flutter/material.dart';

class Achievement {
  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.badgeImageUrl,
    required this.accent,
  });

  final String id;
  final String title;
  final String description;
  final double progress;
  final String badgeImageUrl;
  final Color accent;
}
