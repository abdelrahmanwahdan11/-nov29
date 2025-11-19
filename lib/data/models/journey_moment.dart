import 'package:flutter/material.dart';

class JourneyMoment {
  const JourneyMoment({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.metricLabel,
    required this.metricValue,
    required this.storySegments,
    required this.accentColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String metricLabel;
  final String metricValue;
  final List<String> storySegments;
  final Color accentColor;
}
