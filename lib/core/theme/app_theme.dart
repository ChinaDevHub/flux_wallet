import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/theme/app_palettes.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(lightColors, Brightness.light);
  static ThemeData get dark => _build(darkColors, Brightness.dark);

  static ThemeData _build(AppColors c, Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: c.primary,
        brightness: brightness,
        primary: c.primary,
        surface: c.surface,
      ),
      dividerColor: c.divider,
      splashFactory: InkSparkle.splashFactory,
      textTheme: Typography.material2021().black.apply(
        bodyColor: c.text,
        displayColor: c.text,
      ),
      extensions: [c],
    );
  }
}
