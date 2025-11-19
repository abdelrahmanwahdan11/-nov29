import 'package:flutter/material.dart';

class RideJournalEntry {
  const RideJournalEntry({
    required this.id,
    required this.title,
    required this.route,
    required this.mood,
    required this.note,
    required this.vehicle,
    required this.timestamp,
    required this.rating,
    required this.tags,
    required this.highlights,
    required this.accent,
  });

  final String id;
  final String title;
  final String route;
  final String mood;
  final String note;
  final String vehicle;
  final DateTime timestamp;
  final double rating;
  final List<String> tags;
  final List<String> highlights;
  final Color accent;
}
