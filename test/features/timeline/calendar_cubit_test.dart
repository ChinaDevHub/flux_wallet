import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import '../../support/test_env.dart';

void main() {
  final now = DateTime(2026, 10, 24, 9);
  late TestEnv env;
  late TimelineCubit cubit;

  setUp(() async {
    env = await openTestEnv(now: now);
    await env.repos.onboarding.complete(
      const OnboardingData(cardBalance: 300, cashBalance: 0),
      now,
    );
    final u = env.useCases;
    cubit = TimelineCubit(
      u.loadTimeline,
      u.loadCalendarBounds,
      u.scheduleEditor,
      () => now,
      env.db.changes,
    );
    await cubit.load();
  });
  tearDown(() async {
    await cubit.close();
    await env.close();
  });

  TimelineLoaded loaded() => cubit.state as TimelineLoaded;

  test('opens on today, in this month', () {
    expect(loaded().month, DateTime(2026, 10));
    expect(loaded().selected, DateTime(2026, 10, 24));
    expect(loaded().selectedDay.isToday, isTrue);
  });

  test(
    'picking a day keeps the month; another month starts on its 1st',
    () async {
      cubit.selectDay(DateTime(2026, 10, 28));
      expect(loaded().selected, DateTime(2026, 10, 28));
      expect(loaded().selectedDay.isFuture, isTrue);

      await cubit.selectMonth(DateTime(2026, 12, 15));
      expect(loaded().month, DateTime(2026, 12));
      expect(loaded().selected, DateTime(2026, 12));

      await cubit.goToToday();
      expect(loaded().selected, DateTime(2026, 10, 24));
    },
  );

  test('a picked day survives a reload caused by an edit', () async {
    cubit.selectDay(DateTime(2026, 10, 27));
    await cubit.setDayOff(DateTime(2026, 10, 27), true);
    await cubit.load();
    expect(loaded().selected, DateTime(2026, 10, 27));
    expect(loaded().selectedDay.isDayOff, isTrue);
  });

  test('the calendar covers the start day to three months ahead', () {
    final b = loaded().bounds;
    expect(b.months.first, DateTime(2026, 10));
    expect(b.months.last, DateTime(2027, 1));
    expect(b.hasMonthBefore(DateTime(2026, 10)), isFalse);
    expect(b.hasMonthAfter(DateTime(2027, 1)), isFalse);
  });
}
