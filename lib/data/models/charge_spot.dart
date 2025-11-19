class ChargeSpot {
  const ChargeSpot({
    required this.id,
    required this.name,
    required this.neighborhood,
    required this.imageUrl,
    required this.status,
    required this.availablePods,
    required this.totalPods,
    required this.powerKw,
    required this.waitMinutes,
    required this.energyType,
    required this.amenities,
    required this.lastUpdated,
  });

  final String id;
  final String name;
  final String neighborhood;
  final String imageUrl;
  final String status;
  final int availablePods;
  final int totalPods;
  final double powerKw;
  final int waitMinutes;
  final String energyType;
  final List<String> amenities;
  final String lastUpdated;
}
