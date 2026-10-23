import 'package:flutter/material.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_entry_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/lock_caption.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_dots.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_title.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view.dart';

/// Title, subtitle, the dots and the caption line.
class PinEntryTop extends StatelessWidget {
  const PinEntryTop({
    super.key,
    required this.view,
    required this.state,
    required this.shakeTick,
  });

  final PinEntryView view;
  final PinEntryState state;
  final int shakeTick;

  @override
  Widget build(BuildContext context) {
    final p = view.prompt;
    final failed = p.captionError && p.caption != null && state.isEmpty;
    return Column(
      children: [
        PinEntryTitle(title: p.title, subtitle: p.subtitle),
        const SizedBox(height: 28),
        PinDots(
          length: state.length,
          filled: state.digits.length,
          error: failed,
          shakeTick: shakeTick,
        ),
        const SizedBox(height: 14),
        LockCaption(text: p.caption, error: p.captionError),
        if (view.belowDots != null) ...[
          const SizedBox(height: 16),
          view.belowDots!,
        ],
      ],
    );
  }
}
