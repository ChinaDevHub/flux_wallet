import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/primary_button.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';

class RuleEditSave extends StatelessWidget {
  const RuleEditSave({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RuleEditCubit, RuleEditState>(
      buildWhen: (a, b) => a.canSubmit != b.canSubmit || a.status != b.status,
      builder: (context, s) => PrimaryButton(
        label: 'Yadda saxla',
        loading: s.status == RuleSaveStatus.saving,
        onPressed: s.canSubmit ? context.read<RuleEditCubit>().submit : null,
      ),
    );
  }
}
