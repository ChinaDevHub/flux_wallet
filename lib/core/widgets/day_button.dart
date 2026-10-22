import 'package:flutter/material.dart';
import 'package:flux_wallet/core/icons/arrow_icons.dart';
import 'package:flux_wallet/core/platform/adaptive_date_picker.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';

/// Shows [date] (or [placeholder]); tapping opens the platform date picker
/// limited to [first]..[last].
class DayButton extends StatelessWidget {
  const DayButton({
    super.key,
    required this.date,
    required this.first,
    required this.last,
    required this.onPicked,
    this.placeholder = 'Tarix seç',
  });

  final DateTime? date;
  final DateTime first, last;
  final ValueChanged<DateTime> onPicked;
  final String placeholder;

  Future<void> _pick(BuildContext context) async {
    final picked = await pickDate(
      context,
      initial: clampDate(date ?? DateTime.now(), first, last),
      first: first,
      last: last,
    );
    if (picked != null) onPicked(picked);
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return TextButton.icon(
      onPressed: () => _pick(context),
      icon: Icon(ArrowIcons.down, color: c.text),
      iconAlignment: IconAlignment.end,
      label: Text(
        date == null ? placeholder : azDayMonth(date!),
        style: TextStyle(color: c.text),
      ),
    );
  }
}
