import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// A ₼ coin that drops behind the logo, as if into the wallet. It is drawn
/// (almost invisibly) from the first frame, so the glyph is already shaped
/// and cached when it appears, instead of costing a frame mid-animation.
class SplashCoin extends StatelessWidget {
  const SplashCoin(this.timeline, {super.key});

  final Animation<double> timeline;

  static final _coin = RepaintBoundary(
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

  @override
  Widget build(BuildContext context) {
    final fall = span(timeline, 0.28, 0.6, Curves.easeInCubic);
    final show = span(timeline, 0.28, 0.34);
    return FadeTransition(
      opacity: show.drive(Tween(begin: 0.004, end: 1.0)),
      child: SlideTransition(
        position: fall.drive(
          Tween(begin: const Offset(0, -3.8), end: const Offset(0, 0.6)),
        ),
        child: _coin,
      ),
    );
  }
}
