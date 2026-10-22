import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// A ring that spreads from the wallet when the coin lands in it.
class SplashRipple extends StatelessWidget {
  const SplashRipple(this.timeline, {super.key});

  final Animation<double> timeline;

  static final _ring = RepaintBoundary(
    child: Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: splashGlow, width: 2),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final t = span(timeline, 0.58, 0.95, Curves.easeOutCubic);
    return FadeTransition(
      opacity: t.drive(Tween(begin: 0.55, end: 0.0)),
      child: ScaleTransition(
        scale: t.drive(Tween(begin: 0.8, end: 2.0)),
        child: _ring,
      ),
    );
  }
}
