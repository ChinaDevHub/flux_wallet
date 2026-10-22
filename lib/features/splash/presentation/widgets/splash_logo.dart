import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/widgets/app_logo.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// The brand tile: pops in, then bumps when the coin lands.
class SplashLogo extends StatelessWidget {
  const SplashLogo(this.timeline, {super.key});

  final Animation<double> timeline;

  static final _bump = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 40),
    TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 60),
  ]);

  @override
  Widget build(BuildContext context) {
    final enter = span(timeline, 0.04, 0.42, Curves.easeOutBack);
    final fade = span(timeline, 0.04, 0.22);
    final bump = span(timeline, 0.58, 0.8, Curves.easeOut).drive(_bump);
    return AnimatedBuilder(
      animation: timeline,
      builder: (context, child) => Opacity(
        opacity: fade.value,
        child: Transform.scale(
          scale: (0.55 + 0.45 * enter.value) * bump.value,
          child: child,
        ),
      ),
      child: const AppLogo(size: 112),
    );
  }
}
