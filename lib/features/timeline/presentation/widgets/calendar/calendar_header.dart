import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_arrow.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_title.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/show_month_picker.dart';

/// Month name and previous / next: iOS puts a large title left of the
/// arrows, Android frames a centred title with them.
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key, required this.state, required this.cubit});

  final TimelineLoaded state;
  final TimelineCubit cubit;

  void _go(int step) =>
      cubit.selectMonth(DateTime(state.month.year, state.month.month + step));

  Future<void> _pick(BuildContext context) async {
    final picked = await showMonthPicker(
      context,
      bounds: state.bounds,
      current: state.month,
    );
    if (picked != null) await cubit.selectMonth(picked);
  }

  @override
  Widget build(BuildContext context) {
    final b = state.bounds;
    final cupertino = context.isCupertino;
    final (prev, next) = monthArrows(b, state.month, _go);
    final title = MonthTitle(
      month: state.month,
      large: cupertino,
      onTap: () => _pick(context),
    );
    return Row(
      children: cupertino
          ? [title, const Spacer(), prev, next]
          : [prev, Expanded(child: Center(child: title)), next],
    );
  }
}
