
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../widgets/app_scaffold.dart';
import '../account/profile_screen.dart';
import '../ai/nex_ai_screen.dart';
import '../catalog/vehicle_catalog_screen.dart';
import '../home/home_trip_planner_screen.dart';
import '../more/more_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  final pages = const [
    HomeTripPlannerScreen(),
    VehicleCatalogScreen(),
    NexAIScreen(),
    ProfileScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useRail = constraints.maxWidth > 900;
        return AppScaffold(
          navigationRail: useRail
              ? NavigationRail(
                  selectedIndex: index,
                  onDestinationSelected: (value) => setState(() => index = value),
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(IconlyBold.location),
                      label: Text('My Trip'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(IconlyBold.category),
                      label: Text('Catalog'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(IconlyBold.activity),
                      label: Text('Nex-AI'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(IconlyBold.profile),
                      label: Text('Account'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(IconlyBold.more_square),
                      label: Text('More'),
                    ),
                  ],
                )
              : null,
          bottomNavigationBar: useRail
              ? null
              : BottomNavigationBar(
                  currentIndex: index,
                  onTap: (value) => setState(() => index = value),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(IconlyBold.location),
                      label: 'My Trip',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconlyBold.category),
                      label: 'Catalog',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconlyBold.activity),
                      label: 'Nex-AI',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconlyBold.profile),
                      label: 'Account',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconlyBold.more_square),
                      label: 'More',
                    ),
                  ],
                ),
          body: IndexedStack(index: index, children: pages),
        );
      },
    );
  }
}
