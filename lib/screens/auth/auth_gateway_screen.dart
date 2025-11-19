
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to NexRide')),
      body: Column(
        children: [
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
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeShell()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
