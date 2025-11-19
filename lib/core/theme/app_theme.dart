import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(Color primary) {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: const Color(0xFF47E7FF),
        background: const Color(0xFFF4F7FB),
        surface: Colors.white.withOpacity(0.9),
      ),
      scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      textTheme: GoogleFonts.interTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFF111827),
      ),
      cardTheme: CardTheme(
        color: Colors.white.withOpacity(0.92),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  static ThemeData dark(Color primary) {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: const Color(0xFFFF6FD8),
        background: const Color(0xFF050814),
        surface: const Color(0xFF111827),
      ),
      scaffoldBackgroundColor: const Color(0xFF050814),
      textTheme: GoogleFonts.interTextTheme(base.textTheme.apply(
        bodyColor: const Color(0xFFF9FAFB),
        displayColor: const Color(0xFFF9FAFB),
      )),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Color(0xFFF9FAFB),
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF111827).withOpacity(0.92),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }
}
