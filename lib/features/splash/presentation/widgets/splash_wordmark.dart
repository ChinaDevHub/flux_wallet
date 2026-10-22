import 'package:flutter/material.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_timeline.dart';

/// "Flux Wallet" and the promise of the app, fading in under the logo.
class SplashWordmark extends StatelessWidget {
  const SplashWordmark(this.timeline, {super.key});

  final Animation<double> timeline;

  @override
  Widget build(BuildContext context) {
    final title = span(timeline, 0.62, 0.86, Curves.easeOutCubic);
    final tagline = span(timeline, 0.74, 0.98);
    return Column(
      spacing: 8,
      children: [
        FadeTransition(
          opacity: title,
          child: SlideTransition(
            position: title.drive(
              Tween(begin: const Offset(0, 0.4), end: Offset.zero),
            ),
            child: const Text(
              'Flux Wallet',
              style: TextStyle(
                fontSize: 32,
                letterSpacing: -0.6,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
        ),
        FadeTransition(
          opacity: tagline,
          child: const Text(
            'Hər gün nə qədər xərcləyə bilərsən',
            style: TextStyle(fontSize: 14, color: splashMuted),
          ),
        ),
      ],
    );
  }
}
