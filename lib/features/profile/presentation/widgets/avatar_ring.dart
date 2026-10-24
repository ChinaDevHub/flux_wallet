import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The frame around a small avatar: a hairline on iOS (like its own
/// account buttons), a brand-tinted ring on Android.
class AvatarRing extends StatelessWidget {
  const AvatarRing({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cupertino = context.isCupertino;
    return Container(
      padding: EdgeInsets.all(cupertino ? 1.5 : 2.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: cupertino ? 1 : 2,
          color: cupertino ? c.divider : c.primary.withValues(alpha: 0.7),
        ),
      ),
      child: child,
    );
  }
}
