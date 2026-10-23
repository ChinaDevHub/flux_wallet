import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/prefilled_amount_field.dart';
import 'package:flux_wallet/core/widgets/prefilled_text_field.dart';
import 'package:flux_wallet/core/widgets/field_kind.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/edit/rule_edit_schedule.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/edit/rule_edit_category.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/edit/rule_edit_save.dart';

/// Title, amount, category, schedule and "from when", then save.
class RuleEditForm extends StatelessWidget {
  const RuleEditForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RuleEditCubit>();
    final s0 = cubit.state;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        PrefilledAmountField(
          initial: s0.amountText,
          onChanged: cubit.setAmountText,
        ),
        const SizedBox(height: 16),
        PrefilledTextField(
          initial: s0.title,
          label: 'Ad',
          kind: FieldKind.name,
          onChanged: cubit.setTitle,
        ),
        const SizedBox(height: 20),
        const RuleEditCategory(),
        const SizedBox(height: 20),
        const RuleEditSchedule(),
        const SizedBox(height: 20),
        const RuleEditSave(),
      ],
    );
  }
}
