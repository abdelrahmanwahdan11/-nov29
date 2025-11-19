import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../data/models/trip.dart';

class TripController extends ChangeNotifier {
  Trip? _activeTrip = trips.first;
  Trip? get activeTrip => _activeTrip;
  Timer? _timer;
  Timer? _countdownTimer;
  final ValueNotifier<String> statusNotifier =
      ValueNotifier<String>(trips.first.status);
  final ValueNotifier<Duration> countdownNotifier =
      ValueNotifier<Duration>(Duration.zero);

  final List<Trip> _historySource =
      List<Trip>.from(trips)..sort((a, b) => b.startTime.compareTo(a.startTime));
  final List<Trip> _visibleHistory = [];
  bool historyLoading = false;
  bool historyPaginating = false;
  String historyFilter = 'All';
  String historyQuery = '';
  int _historyPage = 0;
  static const int _historyPageSize = 3;

  List<Trip> get historyItems {
    Iterable<Trip> data = _visibleHistory;
    if (historyFilter != 'All') {
      data = data.where((trip) =>
          trip.status.toLowerCase() == historyFilter.toLowerCase());
    }
    if (historyQuery.isNotEmpty) {
      final lower = historyQuery.toLowerCase();
      data = data.where((trip) => trip.pickupLocation.toLowerCase().contains(lower) ||
          trip.dropoffLocation.toLowerCase().contains(lower));
    }
    return data.toList();
  }

  bool get canLoadMoreHistory =>
      _visibleHistory.length < _historySource.length && !historyPaginating;

  Future<void> bootstrapHistory() async {
    await _loadHistory(reset: true);
  }

  Future<void> refreshHistory() async {
    await _loadHistory(reset: true, simulateDelay: true);
  }

  Future<void> loadMoreHistory() async {
    await _loadHistory();
  }

  Future<void> _loadHistory({bool reset = false, bool simulateDelay = false}) async {
    if (reset) {
      historyLoading = true;
      historyPaginating = false;
      notifyListeners();
      if (simulateDelay) {
        await Future<void>.delayed(const Duration(milliseconds: 650));
      }
      _historyPage = 1;
      _visibleHistory
        ..clear()
        ..addAll(_historySource.take(_historyPageSize));
      historyLoading = false;
      notifyListeners();
      return;
    }
    if (!canLoadMoreHistory) return;
    historyPaginating = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 600));
    _historyPage += 1;
    final start = (_historyPage - 1) * _historyPageSize;
    final next = _historySource.skip(start).take(_historyPageSize);
    _visibleHistory.addAll(next);
    historyPaginating = false;
    notifyListeners();
  }

  void updateHistoryFilter(String filter) {
    historyFilter = filter;
    notifyListeners();
  }

  void updateHistoryQuery(String query) {
    historyQuery = query;
    notifyListeners();
  }

  void startSimulation() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    final states = [
      'requested',
      'on_the_way',
      'ready_at_pickup',
      'in_progress',
      'completed',
    ];
    var index = 0;
    countdownNotifier.value = _computeCountdown();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (index >= states.length) {
        timer.cancel();
        return;
      }
      statusNotifier.value = states[index];
      _activeTrip = _activeTrip?.copyWith(status: states[index]);
      countdownNotifier.value = _computeCountdown();
      index++;
      notifyListeners();
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      countdownNotifier.value = _computeCountdown();
    });
  }

  Duration _computeCountdown() {
    if (_activeTrip == null) return Duration.zero;
    final now = DateTime.now();
    final pickup = _activeTrip!.scheduledTime;
    if (pickup.isBefore(now)) return Duration.zero;
    return pickup.difference(now);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    statusNotifier.dispose();
    countdownNotifier.dispose();
    super.dispose();
  }
}
