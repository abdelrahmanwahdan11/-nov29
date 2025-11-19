
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.navigationRail,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? navigationRail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF050814), Color(0xFF10172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            children: [
              if (navigationRail != null) navigationRail!,
              Expanded(child: body),
            ],
          ),
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
