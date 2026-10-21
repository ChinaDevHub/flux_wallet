import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// Pull-to-refresh with the platform's spinner (the child must scroll).
class AdaptiveRefresh extends StatelessWidget {
  const AdaptiveRefresh({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  final Future<void> Function() onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      color: c.primary,
      backgroundColor: c.surface,
      child: child,
    );
  }
}
