import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';

/// A round tappable: on iOS it dims while pressed (no ripple), on Android a
/// ripple spreads inside the circle.
class AdaptiveCircleButton extends StatelessWidget {
  const AdaptiveCircleButton({
    super.key,
    required this.onTap,
    required this.semanticLabel,
    required this.child,
  });

  final VoidCallback onTap;
  final String semanticLabel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final button = context.isCupertino
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            pressedOpacity: 0.55,
            onPressed: onTap,
            child: child,
          )
        : Material(
            type: MaterialType.transparency,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(onTap: onTap, child: child),
          );
    return Semantics(button: true, label: semanticLabel, child: button);
  }
}
