import 'package:flutter/material.dart';

/// A black backdrop that fades as [child] is dragged [dy] away from the
/// middle; the child follows the finger.
class DragFade extends StatelessWidget {
  const DragFade({super.key, required this.dy, required this.child});

  final double dy;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fade = (1 - dy.abs() / 500).clamp(0.2, 1.0);
    return ColoredBox(
      color: Colors.black.withValues(alpha: fade),
      child: Transform.translate(offset: Offset(0, dy), child: child),
    );
  }
}
