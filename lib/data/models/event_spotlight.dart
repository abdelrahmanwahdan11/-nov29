class EventSpotlight {
  const EventSpotlight({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.venue,
    required this.category,
    required this.heroImageUrl,
    required this.highlight,
    required this.vibe,
    required this.chips,
  });

  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final String venue;
  final String category;
  final String heroImageUrl;
  final String highlight;
  final String vibe;
  final List<String> chips;
}
