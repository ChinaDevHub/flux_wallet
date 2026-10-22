import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ring chart: one arc per slice, sweeping in as [progress] goes 0 -> 1.
class DonutPainter extends CustomPainter {
  const DonutPainter({
    required this.fractions,
    required this.colors,
    required this.track,
    required this.progress,
  });

  final List<double> fractions;
  final List<Color> colors;
  final Color track;
  final double progress;

  static const _stroke = 26.0;
  static const _gap = 0.02;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arc = rect.deflate(_stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke
      ..strokeCap = StrokeCap.butt;
    canvas.drawArc(arc, 0, math.pi * 2, false, paint..color = track);
    var start = -math.pi / 2;
    for (var i = 0; i < fractions.length; i++) {
      final sweep = math.max(0.0, fractions[i] * math.pi * 2 * progress - _gap);
      canvas.drawArc(arc, start, sweep, false, paint..color = colors[i]);
      start += fractions[i] * math.pi * 2 * progress;
    }
  }

  @override
  bool shouldRepaint(DonutPainter old) =>
      old.progress != progress ||
      old.fractions != fractions ||
      old.colors != colors;
}
