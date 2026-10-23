import 'dart:math';

import 'package:flutter/widgets.dart';

/// Shakes [child] sideways whenever [tick] changes (a wrong PIN, say).
class Shake extends StatefulWidget {
  const Shake({super.key, required this.tick, required this.child});

  final int tick;
  final Widget child;

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  @override
  void didUpdateWidget(Shake old) {
    super.didUpdateWidget(old);
    if (old.tick != widget.tick) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (_, child) {
        final t = _controller.value;
        final dx = sin(t * pi * 5) * 12 * (1 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}
