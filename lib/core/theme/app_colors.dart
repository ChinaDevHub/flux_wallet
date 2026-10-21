import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.primary,
    required this.primaryLight,
    required this.onPrimary,
    required this.text,
    required this.textMuted,
    required this.divider,
    required this.accent,
    required this.accentSoft,
    required this.positive,
    required this.negative,
  });

  final Color background, surface, surfaceAlt, primary, primaryLight;
  final Color onPrimary, text, textMuted, divider;
  final Color accent, accentSoft, positive, negative;

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(AppColors? other, double t) => t < 0.5 ? this : other ?? this;
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
