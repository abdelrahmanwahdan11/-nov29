class PulseForecast {
  const PulseForecast({
    required this.id,
    required this.title,
    required this.summary,
    required this.mapImageUrl,
    required this.timeframe,
    required this.impactLevel,
    required this.tags,
    required this.delayMinutes,
    required this.confidence,
  });

  final String id;
  final String title;
  final String summary;
  final String mapImageUrl;
  final String timeframe;
  final String impactLevel;
  final List<String> tags;
  final int delayMinutes;
  final double confidence;
}
