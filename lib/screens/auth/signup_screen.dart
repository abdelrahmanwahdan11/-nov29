
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = ControllerScope.of(context).auth;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
          TextField(controller: _emailController, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _passwordController, decoration: const InputDecoration(labelText: 'Password')),
          const SizedBox(height: 12),
          PrimaryButton(
            label: 'Create account',
            isLoading: auth.isLoading,
            onPressed: () => auth
                .signup(
                  name: _nameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                )
                .then((_) {
              if (mounted && auth.error == null) {
                Navigator.of(context).pushReplacementNamed('/');
              }
            }),
          ),
          if (auth.error != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(auth.error!, style: const TextStyle(color: Colors.red)),
            ),
        ],
      ),
    );
  }
}
