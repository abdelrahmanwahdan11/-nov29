import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final gradient = LinearGradient(
      colors: [
        colors.primary,
        Color.lerp(colors.primary, const Color(0xFF47E7FF), 0.4)!,
      ],
    );
    final disabled = isLoading || onPressed == null;
    return AnimatedOpacity(
      duration: 200.ms,
      opacity: disabled ? 0.7 : 1,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withOpacity(0.4),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: disabled ? null : onPressed,
            child: SizedBox(
              height: 54,
              child: Center(
                child: (isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            label,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ))
                    .animate()
                    .scale(duration: 200.ms, curve: Curves.easeOut),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
