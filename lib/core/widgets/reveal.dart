import 'package:flutter/material.dart';

/// Slides [child] open while [open], and shut (to nothing) otherwise.
class Reveal extends StatelessWidget {
  const Reveal({super.key, required this.open, required this.child});

  final bool open;
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimatedSize(
    duration: const Duration(milliseconds: 220),
    curve: Curves.easeOut,
    alignment: Alignment.topCenter,
    child: open ? child : const SizedBox(width: double.infinity),
  );
}
