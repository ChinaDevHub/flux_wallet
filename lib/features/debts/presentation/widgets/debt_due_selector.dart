import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_date_picker.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/widgets/form_row.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';

/// When it must be paid back; required only for a debt I took.
class DebtDueSelector extends StatelessWidget {
  const DebtDueSelector({super.key});

  Future<void> _pick(BuildContext context, DateTime? current) async {
    final cubit = context.read<NewDebtCubit>();
    final today = DateTime.now();
    final picked = await pickDate(
      context,
      initial: current ?? today,
      first: DateTime(today.year, today.month, today.day),
      last: DateTime(today.year + 5),
    );
    if (picked != null) cubit.setDue(picked);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<NewDebtCubit, NewDebtState>(
      buildWhen: (a, b) => a.dueDate != b.dueDate || a.direction != b.direction,
      builder: (context, s) => FormRow(
        title: 'Son tarix',
        subtitle: s.needsDueDate
            ? 'Məcburi xərc kimi bu tarixə bağlanır'
            : 'İstəyə bağlı',
        trailing: TextButton(
          onPressed: () => _pick(context, s.dueDate),
          child: Text(
            s.dueDate == null ? 'Tarix seç' : azDayMonth(s.dueDate!),
            style: TextStyle(color: c.text),
          ),
        ),
      ),
    );
  }
}
