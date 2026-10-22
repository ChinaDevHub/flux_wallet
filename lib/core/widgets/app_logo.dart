import 'package:flutter/material.dart';
import 'package:flux_wallet/core/branding/brand_colors.dart';
import 'package:flux_wallet/core/branding/logo_mark_painter.dart';

/// The Flux logo: the brand tile with the mark on it. Same everywhere and in
/// light or dark, and the same drawing the launcher icons are made from.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: brandGradient,
        borderRadius: BorderRadius.circular(size * 0.26),
      ),
      child: const CustomPaint(painter: LogoMarkPainter()),
    );
  }
}
