import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/features/security/presentation/widgets/cupertino_pin_key.dart';
import 'package:flux_wallet/features/security/presentation/widgets/material_pin_key.dart';

/// One keypad button in the platform's own style, with a light tap. iOS
/// digits sit on a disc; [round] false (the backspace glyph) draws none.
class PinKey extends StatelessWidget {
  const PinKey({
    super.key,
    required this.child,
    required this.onTap,
    this.enabled = true,
    this.round = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final bool enabled, round;

  static double width(BuildContext context) =>
      context.isCupertino ? CupertinoPinKey.size : MaterialPinKey.size.width;

  @override
  Widget build(BuildContext context) {
    final on = enabled && onTap != null;
    void tap() {
      HapticFeedback.lightImpact();
      onTap!();
    }

    final face = AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: on ? 1 : 0.35,
      child: child,
    );
    return context.isCupertino && round
        ? CupertinoPinKey(onTap: on ? tap : null, child: face)
        : MaterialPinKey(onTap: on ? tap : null, child: face);
  }
}
