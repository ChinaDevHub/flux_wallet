import 'package:flutter/material.dart';

/// Slide down from above and fade; the same curve reversed on the way out.
Widget alertTransition(Widget child, Animation<double> animation) {
  final curved = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );
  final slide = Tween(begin: const Offset(0, -1.2), end: Offset.zero);
  return FadeTransition(
    opacity: curved,
    child: SlideTransition(position: slide.animate(curved), child: child),
  );
}
