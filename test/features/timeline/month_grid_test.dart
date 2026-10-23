import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/theme/app_theme.dart';
import 'package:flux_wallet/features/timeline/domain/entities/calendar_bounds.dart';
import 'package:flux_wallet/features/timeline/domain/entities/day_limit.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_grid.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/over_dot.dart';

TimelineLoaded november() {
  final today = DateTime(2026, 11, 10);
  final days = [
    for (var d = 1; d <= 30; d++)
      TimelineDay(
        date: DateTime(2026, 11, d),
        entries: const [],
        endBalance: 0,
        isToday: d == 10,
        isPast: d < 10,
        isDayOff: false,
        limit: d < 10 ? DayLimit(budget: 20, spent: d == 3 ? 35 : 5) : null,
      ),
  ];
  return TimelineLoaded(
    view: TimelineView(
      month: DateTime(2026, 11),
      days: days,
      cycle: null,
      lowest: null,
    ),
    bounds: CalendarBounds(
      first: DateTime(2026, 11, 2),
      last: DateTime(2027, 2, 28),
    ),
    selected: today,
    today: today,
  );
}

void main() {
  Future<List<DateTime>> pump(WidgetTester t) async {
    final picked = <DateTime>[];
    await t.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: MonthGrid(state: november(), onSelect: picked.add),
        ),
      ),
    );
    return picked;
  }

  testWidgets('November 2026 starts on Sunday, in six weeks', (t) async {
    await pump(t);
    expect(find.byType(Row), findsNWidgets(6));
    expect(find.text('30'), findsOneWidget);
  });

  testWidgets('tapping a day reports it; a day before the start does not', (
    t,
  ) async {
    final picked = await pump(t);
    await t.tap(find.text('17'));
    await t.tap(find.text('1'));
    expect(picked, [DateTime(2026, 11, 17)]);
  });

  testWidgets('only the day over its limit carries the red dot', (t) async {
    await pump(t);
    final dots = t.widgetList<OverDot>(find.byType(OverDot));
    expect(dots.where((d) => d.visible), hasLength(1));
  });
}
