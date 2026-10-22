import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/day_button.dart';
import 'package:flux_wallet/core/widgets/form_row.dart';

/// "Title / subtitle ... date" row that opens a date picker.
class DayRow extends StatelessWidget {
  const DayRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.first,
    required this.last,
    required this.onPicked,
  });

  final String title, subtitle;
  final DateTime? date;
  final DateTime first, last;
  final ValueChanged<DateTime> onPicked;

  @override
  Widget build(BuildContext context) {
    return FormRow(
      title: title,
      subtitle: subtitle,
      trailing: DayButton(
        date: date,
        first: first,
        last: last,
        onPicked: onPicked,
      ),
    );
  }
}
