
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/controller_scope.dart';
import 'auth/auth_gateway_screen.dart';
import 'onboarding/onboarding_story_screen.dart';
import 'shell/home_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seen_onboarding') ?? false;
    await Future<void>.delayed(const Duration(milliseconds: 1400));
    if (!mounted) return;
    final auth = ControllerScope.of(context).auth;
    final destination = !seen
        ? const OnboardingStoryScreen()
        : auth.isLoggedIn
            ? const HomeShell()
            : const AuthGatewayScreen();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.9),
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(blurRadius: 32, color: Colors.black26),
                ],
              ),
              child: Text('NexRide',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold))
                  .animate()
                  .fadeIn(duration: 600.ms),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator().animate().scale(),
          ],
        ),
      ),
    );
  }
}
