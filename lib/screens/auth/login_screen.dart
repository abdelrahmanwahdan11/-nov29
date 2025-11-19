
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/primary_button.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'layla@nexride.ai');
  final _passwordController = TextEditingController(text: '123456');
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final auth = ControllerScope.of(context).auth;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            obscureText: obscure,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => obscure = !obscure),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                ),
                child: const Text('Forgot password?'),
              ),
              const Text('Strength: Medium'),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Login',
            isLoading: auth.isLoading,
            onPressed: () => auth
                .login(_emailController.text, _passwordController.text)
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
