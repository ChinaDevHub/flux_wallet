import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_key_letters.dart';

/// The digit on a key; iOS adds the phone-pad letters underneath.
class PinKeyFace extends StatelessWidget {
  const PinKeyFace(this.digit, {super.key});

  final int digit;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final cupertino = context.isCupertino;
    final letters = pinKeyLetters[digit];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$digit',
          style: TextStyle(
            fontSize: cupertino ? 30 : 28,
            fontWeight: FontWeight.w500,
            height: 1,
            color: c.text,
          ),
        ),
        if (cupertino && letters.isNotEmpty)
          Text(
            letters,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.6,
              color: c.textMuted,
            ),
          ),
      ],
    );
  }
}
