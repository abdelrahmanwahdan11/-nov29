import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key, this.height = 120, this.width = double.infinity, this.radius = 24});
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surface.withOpacity(0.3);
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms, color: Colors.white.withOpacity(0.2));
  }
}
