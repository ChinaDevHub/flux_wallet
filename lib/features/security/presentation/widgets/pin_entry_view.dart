import 'package:flutter/material.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_prompt.dart';

/// A whole PIN screen body: title, dots, caption and the keypad. It calls
/// [onFilled] once [length] digits are in; bump [resetTick] to shake and
/// clear it (wrong PIN), and give it a new key to start a fresh step.
class PinEntryView extends StatefulWidget {
  const PinEntryView({
    super.key,
    required this.length,
    required this.prompt,
    required this.onFilled,
    this.resetTick = 0,
    this.enabled = true,
    this.header,
    this.belowDots,
    this.footer,
  });

  final int length, resetTick;
  final PinPrompt prompt;
  final bool enabled;
  final ValueChanged<String> onFilled;
  final Widget? header, belowDots, footer;

  @override
  State<PinEntryView> createState() => PinEntryViewState();
}
