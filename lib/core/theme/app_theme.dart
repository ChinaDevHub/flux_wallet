import 'package:flutter/foundation.dart';
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
      // Ripple feedback is Android-native; iOS keeps a plain highlight.
      splashFactory: defaultTargetPlatform == TargetPlatform.iOS
          ? NoSplash.splashFactory
          : InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.text,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      // Platform typography: SF on iOS, Roboto on Android.
      textTheme: Typography.material2021(
        platform: defaultTargetPlatform,
      ).black.apply(bodyColor: c.text, displayColor: c.text),
      extensions: [c],
    );
  }
}
