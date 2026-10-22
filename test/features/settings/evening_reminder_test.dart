import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/settings/domain/repositories/reminder_scheduler.dart';
import 'package:flux_wallet/features/settings/domain/repositories/settings_repository.dart';
import 'package:flux_wallet/features/settings/domain/usecases/evening_reminder.dart';

class _Settings implements SettingsRepository {
  final values = <String, String>{};
  @override
  Future<String?> read(String key) async => values[key];
  @override
  Future<void> write(String key, String value) async => values[key] = value;
}

class _Scheduler implements ReminderScheduler {
  bool allowed = true;
  final scheduled = <(int, int, String)>[];
  int cancelled = 0;

  @override
  Future<bool> requestPermission() async => allowed;
  @override
  Future<void> scheduleDaily(int h, int m, String t, String b) async =>
      scheduled.add((h, m, t));
  @override
  Future<void> cancel() async => cancelled++;
}

void main() {
  late _Settings settings;
  late _Scheduler scheduler;
  late EveningReminder reminder;

  setUp(() {
    settings = _Settings();
    scheduler = _Scheduler();
    reminder = EveningReminder(settings, scheduler);
  });

  test(
    'enabling schedules 21:00 with the cash question and is remembered',
    () async {
      expect(await reminder.enable(), isTrue);
      expect(scheduler.scheduled.single, (21, 0, 'Nağd xərcin oldumu?'));
      expect(await reminder.isEnabled(), isTrue);
    },
  );

  test('a refused permission schedules and stores nothing', () async {
    scheduler.allowed = false;
    expect(await reminder.enable(), isFalse);
    expect(scheduler.scheduled, isEmpty);
    expect(await reminder.isEnabled(), isFalse);
  });

  test('disabling cancels it', () async {
    await reminder.enable();
    await reminder.disable();
    expect(scheduler.cancelled, 1);
    expect(await reminder.isEnabled(), isFalse);
  });

  test('restore reschedules only when it was enabled', () async {
    await reminder.restore();
    expect(scheduler.scheduled, isEmpty);
    await reminder.enable();
    scheduler.scheduled.clear();
    await reminder.restore();
    expect(scheduler.scheduled, hasLength(1));
  });
}
