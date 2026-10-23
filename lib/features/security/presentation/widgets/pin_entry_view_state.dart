import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_entry_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_entry_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_layout.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view.dart';

/// Owns the digit cubit; a changed `resetTick` clears it with a shake.
class PinEntryViewState extends State<PinEntryView> {
  late final _cubit = PinEntryCubit(widget.length);
  int _shake = 0;

  @override
  void initState() {
    super.initState();
    // A PIN screen never shows the keyboard of whatever was under it.
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }

  @override
  void didUpdateWidget(PinEntryView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetTick == widget.resetTick) return;
    _cubit.clear();
    HapticFeedback.heavyImpact();
    setState(() => _shake++);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<PinEntryCubit, PinEntryState>(
        listenWhen: (_, s) => s.isComplete,
        listener: (_, s) => widget.onFilled(s.digits),
        builder: (_, s) =>
            PinEntryLayout(view: widget, state: s, shakeTick: _shake),
      ),
    );
  }
}
