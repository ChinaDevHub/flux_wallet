import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/platform/adaptive_date_picker.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';
import 'package:flux_wallet/core/widgets/form_row.dart';

/// Past dates only: the future is planned by rules, not by transactions.
class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  Future<void> _pick(BuildContext context, DateTime current) async {
    final cubit = context.read<NewTransactionCubit>();
    final picked = await pickDate(
      context,
      initial: current,
      first: DateTime(current.year - 2),
      last: DateTime.now(),
    );
    if (picked != null) cubit.setDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.date != b.date,
      builder: (context, s) => FormRow(
        title: 'Tarix',
        subtitle: 'Əməliyyat vaxtı',
        trailing: TextButton.icon(
          onPressed: () => _pick(context, s.date),
          icon: Icon(Icons.expand_more_rounded, color: c.text),
          iconAlignment: IconAlignment.end,
          label: Text(azDayMonth(s.date), style: TextStyle(color: c.text)),
        ),
      ),
    );
  }
}
