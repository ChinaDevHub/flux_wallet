import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// A ₼ coin that drops behind the logo, as if into the wallet.
class SplashCoin extends StatelessWidget {
  const SplashCoin(this.timeline, {super.key});

  final Animation<double> timeline;

  @override
  Widget build(BuildContext context) {
    final fall = span(timeline, 0.28, 0.6, Curves.easeInCubic);
    final show = span(timeline, 0.28, 0.34);
    return AnimatedBuilder(
      animation: timeline,
      builder: (context, child) => Opacity(
        opacity: show.value,
        child: Transform.translate(
          offset: Offset(0, -130 + 150 * fall.value),
          child: child,
        ),
      ),
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: splashCoin,
        ),
        child: const Text(
          '₼',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w900,
            color: splashBackground,
          ),
        ),
      ),
    );
  }
}
