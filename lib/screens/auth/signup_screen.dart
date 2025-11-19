
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../shell/home_shell.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool agreed = false;
  String? localError;

  @override
  Widget build(BuildContext context) {
    final auth = ControllerScope.of(context).auth;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        GlassCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmController,
                decoration:
                    const InputDecoration(labelText: 'Confirm password'),
                obscureText: true,
              ),
            ],
          ),
        ),
        CheckboxListTile(
          value: agreed,
          onChanged: (value) => setState(() => agreed = value ?? false),
          title: const Text('I agree to terms & conditions'),
        ),
        PrimaryButton(
          label: 'Create account',
          isLoading: auth.isLoading,
          onPressed: () {
            setState(() => localError = null);
            if (_nameController.text.isEmpty ||
                _emailController.text.isEmpty ||
                _passwordController.text.length < 6) {
              setState(() => localError = 'Fill the required fields');
              return;
            }
            if (_passwordController.text != _confirmController.text) {
              setState(() => localError = 'Passwords do not match');
              return;
            }
            if (!agreed) {
              setState(() => localError = 'Accept the terms to continue');
              return;
            }
            auth
                .signup(
                  name: _nameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                )
                .then((_) {
              if (mounted && auth.error == null) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const HomeShell()),
                  (route) => false,
                );
              }
            });
          },
        ),
        if (localError != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(localError!, style: const TextStyle(color: Colors.red)),
          ),
        if (auth.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(auth.error!, style: const TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}
