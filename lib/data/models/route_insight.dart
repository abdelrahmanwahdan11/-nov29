class RouteInsight {
  const RouteInsight({
    required this.id,
    required this.routeName,
    required this.pickup,
    required this.dropoff,
    required this.recommendedWindow,
    required this.congestionLevel,
    required this.co2Saved,
    required this.description,
    required this.mapImageUrl,
    required this.tags,
  });

  final String id;
  final String routeName;
  final String pickup;
  final String dropoff;
  final String recommendedWindow;
  final String congestionLevel;
  final String co2Saved;
  final String description;
  final String mapImageUrl;
  final List<String> tags;
}
