import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../data/models/trip.dart';

class TripController extends ChangeNotifier {
  Trip? _activeTrip = trips.first;
  Trip? get activeTrip => _activeTrip;
  Timer? _timer;
  final ValueNotifier<String> statusNotifier =
      ValueNotifier<String>(trips.first.status);

  void startSimulation() {
    _timer?.cancel();
    final states = [
      'requested',
      'on_the_way',
      'ready_at_pickup',
      'in_progress',
      'completed',
    ];
    var index = 0;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index >= states.length) {
        timer.cancel();
        return;
      }
      statusNotifier.value = states[index];
      _activeTrip = _activeTrip?.copyWith(status: states[index]);
      index++;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    statusNotifier.dispose();
    super.dispose();
  }
}
