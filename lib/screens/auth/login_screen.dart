
import 'package:flutter/material.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../shell/home_shell.dart';
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
  bool rememberMe = true;

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
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
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
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text('Strength: ${_passwordController.text.length >= 8 ? 'Strong' : 'Medium'}',
                    style: Theme.of(context).textTheme.bodySmall),
              ),
              CheckboxListTile(
                value: rememberMe,
                onChanged: (value) => setState(() => rememberMe = value ?? true),
                title: const Text('Remember me'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
                  ),
                  child: const Text('Forgot password?'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: 'Login',
          isLoading: auth.isLoading,
          onPressed: () => auth
              .login(_emailController.text, _passwordController.text)
              .then((_) {
            if (mounted && auth.error == null) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomeShell()),
                (route) => false,
              );
            }
          }),
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
