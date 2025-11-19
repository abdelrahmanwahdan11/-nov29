
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controllers/auth_controller.dart';
import 'controllers/catalog_controller.dart';
import 'controllers/controller_scope.dart';
import 'controllers/localization_controller.dart';
import 'controllers/music_controller.dart';
import 'controllers/search_controller.dart';
import 'controllers/theme_controller.dart';
import 'controllers/trip_controller.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NexRideApp());
}

class NexRideApp extends StatefulWidget {
  const NexRideApp({super.key});

  @override
  State<NexRideApp> createState() => _NexRideAppState();
}

class _NexRideAppState extends State<NexRideApp> {
  late final AuthController auth = AuthController();
  late final ThemeController theme = ThemeController(
    const Color(0xFF2F6BFF),
  );
  final localization = LocalizationController();
  final catalog = CatalogController();
  final trip = TripController();
  final music = MusicController();
  final search = SearchController();
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.wait([
      auth.load(),
      theme.load(),
      localization.load(),
    ]);
    trip.startSimulation();
    setState(() => initialized = true);
  }

  @override
  void dispose() {
    auth.dispose();
    theme.dispose();
    localization.dispose();
    catalog.dispose();
    trip.dispose();
    music.dispose();
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const MaterialApp(home: SizedBox.shrink());
    }
    return ControllerScope(
      auth: auth,
      theme: theme,
      localization: localization,
      catalog: catalog,
      trip: trip,
      music: music,
      search: search,
      child: AnimatedBuilder(
        animation: Listenable.merge([theme, localization]),
        builder: (context, _) {
          return MaterialApp(
            title: 'NexRide AI Mobility',
            theme: AppTheme.light(theme.primaryColor),
            darkTheme: AppTheme.dark(theme.primaryColor),
            themeMode: theme.mode,
            locale: localization.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
