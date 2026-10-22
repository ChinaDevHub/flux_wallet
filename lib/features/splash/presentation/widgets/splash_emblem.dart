import 'package:flutter/widgets.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_coin.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_glow.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_logo.dart';
import 'package:flux_wallet/features/splash/presentation/widgets/splash_ripple.dart';

/// Glow, ripple, coin and logo, layered back to front (the coin sits behind
/// the tile so it seems to drop into the wallet).
class SplashEmblem extends StatelessWidget {
  const SplashEmblem(this.timeline, {super.key});

  final Animation<double> timeline;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SplashGlow(timeline),
            SplashRipple(timeline),
            SplashCoin(timeline),
            SplashLogo(timeline),
          ],
        ),
      ),
    );
  }
}
