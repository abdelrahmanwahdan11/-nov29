class Trip {
  final String id;
  final String status;
  final String vehicleId;
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime scheduledTime;
  final DateTime startTime;
  final DateTime endTime;
  final double price;
  final double distanceKm;
  final String shareLink;
  final String mapImageUrl;

  const Trip({
    required this.id,
    required this.status,
    required this.vehicleId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.scheduledTime,
    required this.startTime,
    required this.endTime,
    required this.price,
    required this.distanceKm,
    required this.shareLink,
    required this.mapImageUrl,
  });

  Trip copyWith({String? status}) {
    return Trip(
      id: id,
      status: status ?? this.status,
      vehicleId: vehicleId,
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      scheduledTime: scheduledTime,
      startTime: startTime,
      endTime: endTime,
      price: price,
      distanceKm: distanceKm,
      shareLink: shareLink,
      mapImageUrl: mapImageUrl,
    );
  }
}
