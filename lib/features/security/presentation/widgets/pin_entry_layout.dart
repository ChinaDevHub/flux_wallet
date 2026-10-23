import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_entry_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_entry_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_top.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_keypad.dart';

/// Text and dots up top, the pad at the bottom where the thumb is.
class PinEntryLayout extends StatelessWidget {
  const PinEntryLayout({
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
    final cubit = context.read<PinEntryCubit>();
    // Full width, or a short title would shrink the column to the left.
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ?view.header,
          const Spacer(flex: 2),
          PinEntryTop(view: view, state: state, shakeTick: shakeTick),
          const Spacer(flex: 3),
          PinKeypad(
            enabled: view.enabled && !state.isComplete,
            canBackspace: view.enabled && !state.isEmpty,
            onDigit: cubit.add,
            onBackspace: cubit.backspace,
          ),
          const SizedBox(height: 16),
          SizedBox(height: 44, child: view.footer),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
