import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:flux_wallet/core/branding/brand_colors.dart';
import 'package:flux_wallet/core/branding/manat_path.dart';

/// The Flux mark: a daily-limit ring that is not quite closed, a manat sign
/// inside it, and a coin riding on the ring's end. Drawn into the square it
/// gets; [scale] < 1 shrinks it around the centre (for masked icons).
class LogoMarkPainter extends CustomPainter {
  const LogoMarkPainter({
    this.ink = brandInk,
    this.coin = brandCoin,
    this.scale = 1,
  });

  final Color ink, coin;
  final double scale;

  static const _radius = 0.31, _stroke = 0.075, _start = -math.pi / 2;
  static const _sweep = 290 * math.pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    canvas
      ..save()
      ..translate(s / 2, s / 2)
      ..scale(scale)
      ..translate(-s / 2, -s / 2);
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = s * _stroke;
    final center = Offset(s / 2, s / 2), r = s * _radius;
    canvas.drawCircle(center, r, line..color = ink.withAlpha(46));
    final arc = Rect.fromCircle(center: center, radius: r);
    canvas.drawArc(arc, _start, _sweep, false, line..color = ink);
    canvas.drawPath(manatPath(s), line..strokeWidth = s * 0.062);
    final end = _start + _sweep;
    final dot = center + Offset(math.cos(end), math.sin(end)) * r;
    canvas.drawCircle(dot, s * 0.062, Paint()..color = coin);
    canvas.restore();
  }

  @override
  bool shouldRepaint(LogoMarkPainter old) =>
      old.ink != ink || old.coin != coin || old.scale != scale;
}
