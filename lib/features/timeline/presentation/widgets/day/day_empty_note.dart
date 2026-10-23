import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

class DayEmptyNote extends StatelessWidget {
  const DayEmptyNote(this.day, {super.key});

  final TimelineDay day;

  String get _text {
    if (day.isPast) return 'Bu gün əməliyyat olmayıb';
    if (day.isDayOff) return 'İşə getmirəm: iş günü xərcləri söndürülüb';
    if (day.date.weekday > DateTime.friday) return 'Həftə sonu: plan yoxdur';
    return 'Bu gün üçün plan yoxdur';
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(18),
    child: Text(_text, style: TextStyle(color: context.colors.textMuted)),
  );
}
