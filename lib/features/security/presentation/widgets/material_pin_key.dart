import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/features/security/presentation/widgets/cupertino_pin_key.dart';

/// Android lock-screen key: a flat glyph with a round ripple. Also the plain
/// (disc-less) backspace key on iOS, sized like the discs around it.
class MaterialPinKey extends StatelessWidget {
  const MaterialPinKey({super.key, required this.child, required this.onTap});

  static const size = Size(84, 64);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final side = context.isCupertino ? CupertinoPinKey.size : null;
    return SizedBox(
      width: side ?? size.width,
      height: side ?? size.height,
      child: InkResponse(
        onTap: onTap,
        radius: 40,
        child: Center(child: child),
      ),
    );
  }
}
