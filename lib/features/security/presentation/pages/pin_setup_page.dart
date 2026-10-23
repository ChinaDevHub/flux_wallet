import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_cubit.dart';
import 'package:flux_wallet/features/security/presentation/cubit/pin_flow_state.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_entry_view.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_flow_texts.dart';
import 'package:flux_wallet/features/security/presentation/widgets/pin_length_toggle.dart';

/// Set / change / remove the PIN: one pad per step, closes itself when done.
class PinSetupPage extends StatelessWidget {
  const PinSetupPage({super.key, required this.mode});

  final PinFlowMode mode;

  void _onDone(BuildContext context) {
    context.alerts.success(pinDoneMessage(mode));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PinFlowCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(pinFlowTitle(mode))),
      body: SafeArea(
        child: BlocConsumer<PinFlowCubit, PinFlowState>(
          listenWhen: (_, s) => s.step == PinFlowStep.done,
          listener: (context, _) => _onDone(context),
          builder: (context, s) => PinEntryView(
            key: ValueKey('${s.step.name}-${s.activeLength}'),
            length: s.activeLength,
            prompt: pinStepPrompt(s, mode),
            resetTick: s.resetTick,
            enabled: !s.saving && s.step != PinFlowStep.done,
            belowDots: s.step == PinFlowStep.enter
                ? PinLengthToggle(
                    selected: s.length,
                    onChanged: cubit.setLength,
                  )
                : null,
            onFilled: cubit.submit,
          ),
        ),
      ),
    );
  }
}
