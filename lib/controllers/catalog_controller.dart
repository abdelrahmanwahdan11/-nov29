import 'dart:async';

import 'package:flutter/foundation.dart';

import '../data/mock/mock_data.dart';
import '../data/models/vehicle.dart';

class CatalogController extends ChangeNotifier {
  final List<Vehicle> _items = [];
  List<Vehicle> get items => List.unmodifiable(_items);
  final List<Vehicle> _compare = [];
  List<Vehicle> get compareList => List.unmodifiable(_compare);
  String query = '';
  String category = 'All';
  double? maxPrice;
  int? minSeats;
  String sort = 'Recommended';
  bool isLoading = false;
  bool isPaginating = false;
  int _page = 0;
  static const int _pageSize = 2;

  CatalogController() {
    _simulateLoad();
  }

  Future<void> refresh() async {
    _page = 0;
    _items.clear();
    await _simulateLoad();
  }

  Future<void> _simulateLoad() async {
    isLoading = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 650));
    _page = 1;
    _items
      ..clear()
      ..addAll(vehicles.take(_pageSize));
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isPaginating || _items.length >= vehicles.length) return;
    isPaginating = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 700));
    _page += 1;
    final start = (_page - 1) * _pageSize;
    final next = vehicles.skip(start).take(_pageSize);
    _items.addAll(next);
    isPaginating = false;
    notifyListeners();
  }

  void toggleCompare(Vehicle vehicle) {
    if (_compare.contains(vehicle)) {
      _compare.remove(vehicle);
    } else if (_compare.length < 3) {
      _compare.add(vehicle);
    }
    notifyListeners();
  }

  void updateQuery(String value) {
    query = value;
    notifyListeners();
  }

  void updateCategory(String value) {
    category = value;
    notifyListeners();
  }

  void updateMaxPrice(double? value) {
    maxPrice = value;
    notifyListeners();
  }

  void updateMinSeats(int? value) {
    minSeats = value;
    notifyListeners();
  }

  void updateSort(String value) {
    sort = value;
    notifyListeners();
  }

  List<Vehicle> filteredItems() {
    Iterable<Vehicle> view = _items;
    if (query.isNotEmpty) {
      view = view.where((v) =>
          v.brand.toLowerCase().contains(query.toLowerCase()) ||
          v.model.toLowerCase().contains(query.toLowerCase()));
    }
    if (category != 'All') {
      view = view.where(
          (v) => v.category.toLowerCase() == category.toLowerCase());
    }
    if (maxPrice != null) {
      view = view.where((v) => v.basePrice <= maxPrice!);
    }
    if (minSeats != null) {
      view = view.where((v) => v.seats >= minSeats!);
    }
    final sorted = view.toList();
    switch (sort) {
      case 'Price':
        sorted.sort((a, b) => a.basePrice.compareTo(b.basePrice));
        break;
      case 'Range':
        sorted.sort((a, b) => b.rangeKm.compareTo(a.rangeKm));
        break;
      case 'Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        break;
    }
    return sorted;
  }
}
