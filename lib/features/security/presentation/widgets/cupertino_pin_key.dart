import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// iOS passcode key: a round translucent disc that lights while pressed.
class CupertinoPinKey extends StatefulWidget {
  const CupertinoPinKey({super.key, required this.child, required this.onTap});

  static const size = 76.0;

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<CupertinoPinKey> createState() => _CupertinoPinKeyState();
}

class _CupertinoPinKeyState extends State<CupertinoPinKey> {
  bool _pressed = false;

  void _press(bool down) => setState(() => _pressed = down);

  void _release(TapUpDetails _) {
    _press(false);
    widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final on = widget.onTap != null;
    return GestureDetector(
      onTapDown: on ? (_) => _press(true) : null,
      onTapCancel: () => _press(false),
      onTapUp: on ? _release : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 110),
        width: CupertinoPinKey.size,
        height: CupertinoPinKey.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _pressed ? c.primary.withValues(alpha: 0.35) : c.surfaceAlt,
        ),
        child: widget.child,
      ),
    );
  }
}
