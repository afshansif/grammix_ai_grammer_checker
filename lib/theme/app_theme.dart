import 'package:flutter/material.dart';

/// Dark, teal-only palette. Keep this file as the single source
/// of truth for color so the UI stays consistent.
class AppColors {
  static const background = Color(0xFF0A1413);
  static const surface = Color(0xFF102220);
  static const userBubble = Color(0xFF1F6F63); // brighter, saturated teal
  static const assistantBubble = Color(0xFF132523); // deep, muted teal
  static const errorBubble = Color(0xFF3A2020);
  static const accent = Color(0xFF2DD4BF);
  static const textPrimary = Color(0xFFE9F5F3);
  static const textSecondary = Color(0xFF7FA39D);
  static const errorText = Color(0xFFE2A6A2);
}

ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 15, height: 1.4),
      bodyMedium: TextStyle(color: AppColors.textPrimary, fontSize: 15, height: 1.4),
      bodySmall: TextStyle(color: AppColors.textSecondary, fontSize: 13),
    ),
  );
}
