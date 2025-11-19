
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../shell/home_shell.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class AuthGatewayScreen extends StatefulWidget {
  const AuthGatewayScreen({super.key});

  @override
  State<AuthGatewayScreen> createState() => _AuthGatewayScreenState();
}

class _AuthGatewayScreenState extends State<AuthGatewayScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final auth = ControllerScope.of(context).auth;
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to NexRide')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Ride in glassmorphism comfort',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Sign in or create an account to sync trips, playlists and AI preferences.'),
                ],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: const [Tab(text: 'Login'), Tab(text: 'Sign up')],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [LoginScreen(), SignupScreen()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              label: 'Continue as guest',
              onPressed: () async {
                await auth.continueAsGuest();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomeShell()),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
