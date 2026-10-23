import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/core/widgets/muted_text.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/day_caption.dart';

/// "Cümə, 23 Oktyabr" over "3 gün sonra", with a way back to today.
class DayHeader extends StatelessWidget {
  const DayHeader({
    super.key,
    required this.date,
    required this.today,
    required this.onToday,
  });

  final DateTime date, today;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final caption = dayCaption(date, today);
    final title = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: c.text,
    );
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(azFullDate(date), style: title),
              MutedText(caption),
            ],
          ),
        ),
        if (date != today)
          ActionChip(
            label: const Text('Bu gün'),
            onPressed: onToday,
            backgroundColor: c.surfaceAlt,
            side: BorderSide.none,
            shape: const StadiumBorder(),
          ),
      ],
    );
  }
}
