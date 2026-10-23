import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/security_icons.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_key.dart';

/// The delete key: no disc on iOS, like the system passcode pad.
class PinBackspaceKey extends StatelessWidget {
  const PinBackspaceKey({
    super.key,
    required this.onTap,
    required this.enabled,
  });

  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PinKey(
      round: false,
      enabled: enabled,
      onTap: onTap,
      child: Icon(
        SecurityIcons.backspace,
        size: 26,
        color: context.colors.text,
      ),
    );
  }
}
