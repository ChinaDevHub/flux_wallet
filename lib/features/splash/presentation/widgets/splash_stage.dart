import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_colors.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_emblem.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_wordmark.dart';

/// The splash scene: always dark, whatever theme the app uses.
class SplashStage extends StatelessWidget {
  const SplashStage(this.timeline, {super.key});

  final Animation<double> timeline;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.dark,
      child: Material(
        color: splashBackground,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SplashEmblem(timeline),
              SplashWordmark(timeline),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
