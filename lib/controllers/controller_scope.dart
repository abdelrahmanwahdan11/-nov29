
import 'package:flutter/widgets.dart';

import 'auth_controller.dart';
import 'catalog_controller.dart';
import 'localization_controller.dart';
import 'music_controller.dart';
import 'search_controller.dart';
import 'theme_controller.dart';
import 'trip_controller.dart';

class ControllerScope extends InheritedWidget {
  const ControllerScope({
    super.key,
    required super.child,
    required this.auth,
    required this.theme,
    required this.localization,
    required this.catalog,
    required this.trip,
    required this.music,
    required this.search,
  });

  final AuthController auth;
  final ThemeController theme;
  final LocalizationController localization;
  final CatalogController catalog;
  final TripController trip;
  final MusicController music;
  final SearchController search;

  static ControllerScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ControllerScope>();
    assert(scope != null, 'ControllerScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(ControllerScope oldWidget) =>
      auth != oldWidget.auth ||
      theme != oldWidget.theme ||
      localization != oldWidget.localization ||
      catalog != oldWidget.catalog ||
      trip != oldWidget.trip ||
      music != oldWidget.music ||
      search != oldWidget.search;
}
