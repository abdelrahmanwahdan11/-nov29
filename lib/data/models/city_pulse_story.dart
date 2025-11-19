class CityPulseStory {
  const CityPulseStory({
    required this.id,
    required this.title,
    required this.description,
    required this.tag,
    required this.imageUrl,
    required this.publishedAt,
    this.highlight,
  });

  final String id;
  final String title;
  final String description;
  final String tag;
  final String imageUrl;
  final DateTime publishedAt;
  final String? highlight;
}
