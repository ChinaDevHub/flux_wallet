import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_backspace_key.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_key.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_key_face.dart';

/// 1-9 in three rows, then 0 with backspace to its right and [leading] left.
/// [canBackspace] is the caller's call (digits typed, pad enabled).
class PinKeypad extends StatelessWidget {
  const PinKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.enabled = true,
    this.canBackspace = true,
    this.leading,
  });

  final ValueChanged<int> onDigit;
  final VoidCallback onBackspace;
  final bool enabled, canBackspace;
  final Widget? leading;

  Widget _digit(int d) =>
      PinKey(enabled: enabled, onTap: () => onDigit(d), child: PinKeyFace(d));

  Widget _row(List<Widget> keys) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: keys);

  @override
  Widget build(BuildContext context) {
    final cupertino = context.isCupertino;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: cupertino ? 296 : 312),
      child: Column(
        spacing: cupertino ? 16 : 2,
        children: [
          for (var r = 0; r < 3; r++)
            _row([for (var d = 1; d <= 3; d++) _digit(r * 3 + d)]),
          _row([
            SizedBox(width: PinKey.width(context), child: leading),
            _digit(0),
            PinBackspaceKey(enabled: canBackspace, onTap: onBackspace),
          ]),
        ],
      ),
    );
  }
}
