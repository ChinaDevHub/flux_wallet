import 'package:flutter/material.dart';
import 'package:flux_wallet/features/profile/presentation/viewer/drag_fade.dart';

/// Pinch to zoom (up to 4x, double tap resets). While not zoomed, dragging
/// the picture up or down makes the black fade and, far enough, closes it,
/// as in photo apps. The viewer's own gestures report the drag, so zoom and
/// swipe never fight.
class ZoomableDismiss extends StatefulWidget {
  const ZoomableDismiss({super.key, required this.child});

  final Widget child;

  @override
  State<ZoomableDismiss> createState() => _ZoomableDismissState();
}

class _ZoomableDismissState extends State<ZoomableDismiss> {
  final _zoom = TransformationController();
  double _dy = 0;

  bool get _zoomed => _zoom.value.getMaxScaleOnAxis() > 1.01;

  void _drag(ScaleUpdateDetails d) {
    if (_zoomed || d.pointerCount != 1) return;
    setState(() => _dy += d.focalPointDelta.dy);
  }

  void _end(ScaleEndDetails d) {
    final fling = d.velocity.pixelsPerSecond.dy.abs() > 900;
    if (!_zoomed && (_dy.abs() > 140 || fling)) return Navigator.pop(context);
    setState(() => _dy = 0);
  }

  @override
  void dispose() {
    _zoom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragFade(
      dy: _dy,
      child: GestureDetector(
        onDoubleTap: () => setState(() => _zoom.value = Matrix4.identity()),
        child: InteractiveViewer(
          transformationController: _zoom,
          maxScale: 4,
          onInteractionUpdate: _drag,
          onInteractionEnd: _end,
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
