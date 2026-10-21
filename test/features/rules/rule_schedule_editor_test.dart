import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/load_schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    show
        databaseFactory,
        databaseFactoryFfi,
        inMemoryDatabasePath,
        sqfliteFfiInit;

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  final today = DateTime(2026, 10, 20);
  const expander = RecurrenceExpander();

  late AppDatabase db;
  late AppRepositories repos;
  late RuleScheduleEditor editor;
  late RecurringRule bus;

  setUp(() async {
    db = AppDatabase(path: inMemoryDatabasePath);
    repos = AppRepositories(db);
    editor = RuleScheduleEditor(repos.rules, repos.exceptions, repos.dayFlags);
    final id = await repos.rules.add(
      RecurringRule(
        title: 'Avtobus',
        amount: 1,
        category: 'bus',
        frequency: Frequency.weekdays,
        startDate: DateTime(2026, 9, 1),
      ),
    );
    bus = (await repos.rules.getAll()).firstWhere((r) => r.id == id);
  });

  tearDown(() => db.close());

  Future<List<DateTime>> occurrences() async {
    final ctx = await LoadScheduleContext(repos.dayFlags, repos.exceptions)(
      today,
    );
    final rule = (await repos.rules.getAll()).single;
    return expander.expand(rule, today, DateTime(2026, 10, 26), ctx: ctx);
  }

  test('skipOnce removes a single occurrence', () async {
    await editor.skipOnce(bus, DateTime(2026, 10, 22));
    expect((await occurrences()).map((d) => d.day), [20, 21, 23, 26]);
  });

  test('endFrom ends the rule the day before', () async {
    await editor.endFrom(bus, DateTime(2026, 10, 22));
    expect((await occurrences()).map((d) => d.day), [20, 21]);
  });

  test('endFrom on the start date deactivates the rule', () async {
    await editor.endFrom(bus, DateTime(2026, 9, 1));
    expect((await repos.rules.getActive()), isEmpty);
  });

  test('a day off removes weekday rules only for that day', () async {
    await editor.setDayOff(DateTime(2026, 10, 21), off: true);
    expect((await occurrences()).map((d) => d.day), [20, 22, 23, 26]);
    await editor.setDayOff(DateTime(2026, 10, 21), off: false);
    expect(await occurrences(), hasLength(5));
  });

  test('writes notify listeners', () async {
    final events = <void>[];
    final sub = db.changes.listen(events.add);
    await editor.skipOnce(bus, DateTime(2026, 10, 22));
    await Future<void>.delayed(Duration.zero);
    expect(events, hasLength(1));
    await sub.cancel();
  });
}
