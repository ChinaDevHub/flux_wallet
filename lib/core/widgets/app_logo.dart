import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/wallet_mark_painter.dart';

/// The brand tile: a green rounded square with the wallet mark.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final lit = Color.alphaBlend(Colors.white.withAlpha(26), c.primary);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [lit, c.primary],
        ),
        borderRadius: BorderRadius.circular(size * 0.32),
      ),
      child: CustomPaint(
        painter: WalletMarkPainter(ink: c.onPrimary, cut: c.primary),
      ),
    );
  }
}
