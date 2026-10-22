import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// A ring that spreads from the wallet when the coin lands in it.
class SplashRipple extends StatelessWidget {
  const SplashRipple(this.timeline, {super.key});

  final Animation<double> timeline;

  @override
  Widget build(BuildContext context) {
    final t = span(timeline, 0.58, 0.95, Curves.easeOutCubic);
    return AnimatedBuilder(
      animation: t,
      builder: (context, child) => Opacity(
        opacity: (1 - t.value) * 0.55,
        child: Transform.scale(scale: 0.8 + t.value * 1.2, child: child),
      ),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: splashGlow, width: 2),
        ),
      ),
    );
  }
}
