class RideOption {
  final String id;
  final String vehicleId;
  final String pickupLocation;
  final String dropoffLocation;
  final int durationMin;
  final double price;
  final double distanceKm;
  final DateTime leaveAt;
  final int maxPersons;

  const RideOption({
    required this.id,
    required this.vehicleId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.durationMin,
    required this.price,
    required this.distanceKm,
    required this.leaveAt,
    required this.maxPersons,
  });
}
