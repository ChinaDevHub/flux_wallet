import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The line under the dots: attempts left, cooldown, or a flow message.
/// Fixed height, so the pad never jumps when it appears.
class LockCaption extends StatelessWidget {
  const LockCaption({super.key, this.text, this.error = false});

  final String? text;
  final bool error;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: 20,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: text == null
            ? const SizedBox.shrink(key: ValueKey('none'))
            : Text(
                text!,
                key: ValueKey(text),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: error ? c.negative : c.textMuted,
                ),
              ),
      ),
    );
  }
}
