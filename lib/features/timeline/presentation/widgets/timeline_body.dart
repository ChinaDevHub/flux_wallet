import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/income_cycle_card.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/month_selector.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/show_timeline_sheets.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_list.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_top_bar.dart';

class TimelineBody extends StatelessWidget {
  const TimelineBody({
    super.key,
    required this.view,
    required this.monthOffset,
    required this.cubit,
  });

  final TimelineView view;
  final int monthOffset;
  final TimelineCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        spacing: 12,
        children: [
          const TimelineTopBar(),
          MonthSelector(
            month: view.month,
            selected: monthOffset,
            onChanged: cubit.selectMonth,
          ),
          if (view.cycle != null) IncomeCycleCard(view.cycle!),
          Expanded(
            child: TimelineList(
              key: ValueKey(view.month),
              view: view,
              onTapDay: (d) => showDaySheet(context, cubit, d),
              onTapEntry: (d, e) => showEntrySheet(context, cubit, d, e),
            ),
          ),
        ],
      ),
    );
  }
}
