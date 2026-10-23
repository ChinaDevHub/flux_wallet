import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_marks.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_number_style.dart';

/// The number of a day in its circle (see `DayNumberStyle`).
class DayNumber extends StatelessWidget {
  const DayNumber({
    super.key,
    required this.date,
    required this.marks,
    required this.cupertino,
  });

  final DateTime date;
  final DayMarks marks;
  final bool cupertino;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: 38,
      height: 38,
      alignment: Alignment.center,
      decoration: marks.circle(c, cupertino: cupertino),
      child: Opacity(
        opacity: marks.enabled ? 1 : 0.3,
        child: Text('${date.day}', style: marks.number(c, date)),
      ),
    );
  }
}
