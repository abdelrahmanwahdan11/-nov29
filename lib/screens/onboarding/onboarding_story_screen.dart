
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/controller_scope.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../auth/auth_gateway_screen.dart';

class OnboardingStoryScreen extends StatefulWidget {
  const OnboardingStoryScreen({super.key});

  @override
  State<OnboardingStoryScreen> createState() => _OnboardingStoryScreenState();
}

class _OnboardingStoryScreenState extends State<OnboardingStoryScreen> {
  final _controller = PageController();
  int _index = 0;
  Timer? _timer;

  final _stories = [
    {
      'title': 'Glass rides, tailored to your rhythm',
      'subtitle': 'Choose EVs, SUVs or sports icons – all curated by Nex AI.',
      'image': 'https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?auto=format&fit=crop&w=1400&q=80',
    },
    {
      'title': 'Trip progress with cinematic clarity',
      'subtitle': 'Track arrivals, share safety status and sync with playlists.',
      'image': 'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=1400&q=80',
    },
    {
      'title': 'AI prepares the cabin for you',
      'subtitle': 'Ambient playlists, route tweaks and comfort cues.',
      'image': 'https://images.unsplash.com/photo-1493238792000-8113da705763?auto=format&fit=crop&w=1400&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;
      _index = (_index + 1) % _stories.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_onboarding', true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const AuthGatewayScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scope = ControllerScope.of(context);
    final theme = scope.theme;
    final localization = scope.localization;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            top: 40,
            right: 16,
            child: TextButton(
              onPressed: _complete,
              child: const Text('Skip'),
            ),
          ),
          PageView.builder(
            controller: _controller,
            onPageChanged: (value) => setState(() => _index = value),
            itemCount: _stories.length,
            itemBuilder: (_, i) {
              final story = _stories[i];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(story['image']!, fit: BoxFit.cover),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 140,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(story['title']!,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: Colors.white)),
                        const SizedBox(height: 12),
                        Text(story['subtitle']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _stories.length,
                    (i) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _index ? colors.primary : Colors.white30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedSwitcher(
                  duration: 300.ms,
                  child: _index == _stories.length - 1
                      ? GlassCard(
                          key: const ValueKey('prefs'),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Preview interface'),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                children: [
                                  ChoiceChip(
                                    label: const Text('English'),
                                    selected:
                                        localization.locale.languageCode == 'en',
                                    onSelected: (_) => localization
                                        .setLocale(const Locale('en', 'US')),
                                  ),
                                  ChoiceChip(
                                    label: const Text('العربية'),
                                    selected:
                                        localization.locale.languageCode == 'ar',
                                    onSelected: (_) => localization
                                        .setLocale(const Locale('ar', 'PS')),
                                  ),
                                ],
                              ),
                              SwitchListTile(
                                value: theme.mode == ThemeMode.dark,
                                onChanged: (value) => theme
                                    .updateMode(value ? ThemeMode.dark : ThemeMode.light),
                                title: const Text('Dark mode preview'),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_index > 0) {
                          _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        } else {
                          _complete();
                        }
                      },
                      child: const Text('Back'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: PrimaryButton(
                        label: _index == _stories.length - 1
                            ? 'Get started'
                            : 'Next',
                        onPressed: () {
                          if (_index == _stories.length - 1) {
                            _complete();
                          } else {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  label: 'Continue as guest',
                  onPressed: _complete,
                ),
              ],
            ).animate().fadeIn(duration: 400.ms),
          ),
        ],
      ),
    );
  }
}
