import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../data/models/trip.dart';
import '../data/models/vehicle.dart';

class SearchController extends ChangeNotifier {
  final List<String> recent = [];
  List<dynamic> results = [];

  void search(String query) {
    if (query.isEmpty) {
      results = [];
      notifyListeners();
      return;
    }
    final lower = query.toLowerCase();
    final vehiclesMatches = vehicles.where((vehicle) =>
        vehicle.brand.toLowerCase().contains(lower) ||
        vehicle.model.toLowerCase().contains(lower) ||
        vehicle.category.toLowerCase().contains(lower));
    final tripsMatches = trips.where((Trip trip) =>
        trip.pickupLocation.toLowerCase().contains(lower) ||
        trip.dropoffLocation.toLowerCase().contains(lower));
    results = [...vehiclesMatches, ...tripsMatches];
    if (recent.length > 6) recent.removeAt(0);
    if (query.isNotEmpty && !recent.contains(query)) {
      recent.add(query);
    }
    notifyListeners();
  }
}
