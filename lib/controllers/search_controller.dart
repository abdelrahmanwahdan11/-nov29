import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../data/models/trip.dart';
import '../data/models/vehicle.dart';

class SearchController extends ChangeNotifier {
  final List<String> recent = [];
  final List<String> suggestions = const [
    'AI comfort ride',
    'Airport pickup',
    'Electric SUV',
  ];
  final List<String> favoriteLocations = const [
    'Downtown HQ plaza',
    'Key Biscayne marina',
    'Little Havana studio',
  ];

  List<Vehicle> vehicleResults = [];
  List<Trip> tripResults = [];
  List<String> locationResults = [];
  bool get hasResults =>
      vehicleResults.isNotEmpty ||
      tripResults.isNotEmpty ||
      locationResults.isNotEmpty;

  void search(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      clear();
      return;
    }
    final lower = trimmed.toLowerCase();
    vehicleResults = vehicles
        .where((vehicle) =>
            vehicle.brand.toLowerCase().contains(lower) ||
            vehicle.model.toLowerCase().contains(lower) ||
            vehicle.category.toLowerCase().contains(lower))
        .toList();
    tripResults = trips
        .where((Trip trip) =>
            trip.pickupLocation.toLowerCase().contains(lower) ||
            trip.dropoffLocation.toLowerCase().contains(lower))
        .toList();
    locationResults = favoriteLocations
        .where((place) => place.toLowerCase().contains(lower))
        .toList();
    if (recent.length > 6) recent.removeAt(0);
    if (trimmed.isNotEmpty && !recent.contains(trimmed)) {
      recent.add(trimmed);
    }
    notifyListeners();
  }

  void clear() {
    vehicleResults = [];
    tripResults = [];
    locationResults = [];
    notifyListeners();
  }
}
