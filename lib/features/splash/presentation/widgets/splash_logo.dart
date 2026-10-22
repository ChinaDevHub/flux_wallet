import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/widgets/app_logo.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// The brand tile: pops in, then bumps when the coin lands. Painted once;
/// only transforms and opacity run per frame.
class SplashLogo extends StatelessWidget {
  const SplashLogo(this.timeline, {super.key});

  final Animation<double> timeline;

  static final _bump = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.08), weight: 40),
    TweenSequenceItem(tween: Tween(begin: 1.08, end: 1.0), weight: 60),
  ]);

  static const _logo = RepaintBoundary(child: AppLogo(size: 112));

  @override
  Widget build(BuildContext context) {
    final enter = span(timeline, 0.04, 0.42, Curves.easeOutBack);
    return FadeTransition(
      opacity: span(timeline, 0.04, 0.22),
      child: ScaleTransition(
        scale: enter.drive(Tween(begin: 0.55, end: 1.0)),
        child: ScaleTransition(
          scale: span(timeline, 0.58, 0.8, Curves.easeOut).drive(_bump),
          child: _logo,
        ),
      ),
    );
  }
}
