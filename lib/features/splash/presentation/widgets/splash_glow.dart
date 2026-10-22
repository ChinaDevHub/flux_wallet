import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// A soft green light that swells behind the logo.
class SplashGlow extends StatelessWidget {
  const SplashGlow(this.timeline, {super.key});

  final Animation<double> timeline;

  @override
  Widget build(BuildContext context) {
    final t = span(timeline, 0, 0.55, Curves.easeOut);
    return FadeTransition(
      opacity: t,
      child: ScaleTransition(
        scale: t.drive(Tween(begin: 0.5, end: 1.0)),
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [splashGlow.withAlpha(110), splashGlow.withAlpha(0)],
            ),
          ),
        ),
      ),
    );
  }
}
