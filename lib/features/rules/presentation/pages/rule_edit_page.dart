import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/alerts/alert_scope.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/edit/rule_edit_form.dart';

class RuleEditPage extends StatelessWidget {
  const RuleEditPage({super.key});

  void _onState(BuildContext context, RuleEditState s) {
    if (s.status == RuleSaveStatus.done) {
      context.alerts.success('Qayda yeniləndi');
      Navigator.pop(context);
    } else {
      context.alerts.error('Yadda saxlamaq alınmadı. Yenidən cəhd et');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RuleEditCubit, RuleEditState>(
      listenWhen: (_, s) =>
          s.status == RuleSaveStatus.done || s.status == RuleSaveStatus.failure,
      listener: _onState,
      child: Scaffold(
        appBar: AppBar(title: const Text('Qaydanı redaktə et')),
        body: const SafeArea(child: RuleEditForm()),
      ),
    );
  }
}
