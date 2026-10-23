import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/core/widgets/day_row.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_cubit.dart';
import 'package:flux_wallet/features/transactions/presentation/cubit/new_transaction_state.dart';

/// Any day from two years back to the end of the calendar: a past or
/// present day is recorded, a later one is planned (a recorded transaction
/// being corrected stays in the past).
class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTransactionCubit, NewTransactionState>(
      buildWhen: (a, b) => a.date != b.date,
      builder: (context, s) => DayRow(
        title: 'Tarix',
        subtitle: s.isPlan ? 'Plan üçün gələcək gün' : 'Əməliyyat vaxtı',
        date: s.date,
        first: DateTime(s.today.year - 2),
        last: s.isEditing ? s.today : CalendarBounds.lastDay(s.today),
        onPicked: context.read<NewTransactionCubit>().setDate,
      ),
    );
  }
}
