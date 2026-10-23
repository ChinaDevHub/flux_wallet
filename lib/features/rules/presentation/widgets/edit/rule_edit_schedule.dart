import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_cubit.dart';
import 'package:flux_wallet/features/rules/presentation/cubit/rule_edit_state.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/edit/rule_edit_from.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/end_kind.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/frequency_chips.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/recurrence/repeat_options.dart';

/// Frequency, its options and the day the change starts from.
class RuleEditSchedule extends StatelessWidget {
  const RuleEditSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RuleEditCubit>();
    return BlocBuilder<RuleEditCubit, RuleEditState>(
      buildWhen: (a, b) => a.plan != b.plan || a.from != b.from,
      builder: (context, s) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          FrequencyChips(
            title: 'Təkrar',
            allowNone: false,
            selected: s.plan.frequency,
            onChanged: cubit.setFrequency,
          ),
          RepeatOptions(
            plan: s.plan,
            start: s.from,
            onChanged: cubit.setPlan,
            endKinds: const [EndKind.never, EndKind.date],
          ),
          RuleEditFrom(state: s, onPicked: cubit.setFrom),
        ],
      ),
    );
  }
}
