import 'package:flutter/rendering.dart';

/// A solid dot with a ring that grows and fades as [t] goes 0 -> 1.
class HaloPainter extends CustomPainter {
  HaloPainter(this.color, this.t);

  final Color color;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final halo = Paint()..color = color.withValues(alpha: 0.45 * (1 - t));
    canvas.drawCircle(c, 3.5 + 3.5 * t, halo);
    canvas.drawCircle(c, 3.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(HaloPainter old) => old.t != t || old.color != color;
}
