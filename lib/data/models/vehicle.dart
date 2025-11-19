class Vehicle {
  final String id;
  final String brand;
  final String model;
  final int year;
  final String category;
  final String imageUrl;
  final int seats;
  final String power;
  final double rangeKm;
  final double basePrice;
  final double rating;
  final List<String> tags;
  final String descriptionShort;
  final String descriptionLong;

  const Vehicle({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.category,
    required this.imageUrl,
    required this.seats,
    required this.power,
    required this.rangeKm,
    required this.basePrice,
    required this.rating,
    required this.tags,
    required this.descriptionShort,
    required this.descriptionLong,
  });
}
