import 'package:flutter/material.dart';

class AppColors {
  final Color background;
  final Color primaryBlue;
  final Color lightBlue;
  final Color white;
  final Color textDark;

  const AppColors({
    required this.background,
    required this.primaryBlue,
    required this.lightBlue,
    required this.white,
    required this.textDark,
  });

  /// Light mode colors
  static const AppColors light = AppColors(
    background: Color(0xFFF5F5F5),
    primaryBlue: Color.fromARGB(255, 0, 40, 85),
    lightBlue: Color(0xFF64B5F6),
    white: Colors.white,
    textDark: Colors.black87,
  );

  /// Dark mode colors
  static const AppColors dark = AppColors(
    background: Color(0xFF121212),
    primaryBlue: Color(0xFF90CAF9),
    lightBlue: Color(0xFF64B5F6),
    white: Color(0xFF1E1E1E),
    textDark: Colors.white,
  );

  /// Get the current theme's AppColors
  static AppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.dark
        : AppColors.light;
  }
}
