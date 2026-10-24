import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/halo_painter.dart';

/// A dot breathing a soft halo while [pulsing] (still with reduced motion).
class PulseDot extends StatefulWidget {
  const PulseDot({super.key, required this.color, this.pulsing = true});

  final Color color;
  final bool pulsing;

  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final still = !widget.pulsing || MediaQuery.disableAnimationsOf(context);
    still ? _c.stop() : _c.repeat();
  }

  @override
  void didUpdateWidget(PulseDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pulsing != widget.pulsing) didChangeDependencies();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 14,
    child: AnimatedBuilder(
      animation: _c,
      builder: (_, _) =>
          CustomPaint(painter: HaloPainter(widget.color, _c.value)),
    ),
  );
}
