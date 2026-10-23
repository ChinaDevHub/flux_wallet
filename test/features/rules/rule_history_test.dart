import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_plan.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_edit.dart';
import '../../support/test_env.dart';

/// Switching off, deleting and editing a rule never rewrite the days that
/// are over: the limits of past days stay what they were.
void main() {
  final today = DateTime(2026, 10, 20); // Tuesday
  late TestEnv env;
  late RecurringRule rent;

  setUp(() async {
    env = await openTestEnv(now: today);
    final id = await env.repos.rules.add(
      RecurringRule(
        title: 'Kredit',
        amount: 100,
        category: 'other',
        frequency: Frequency.monthly,
        startDate: DateTime(2026, 7, 15),
      ),
    );
    rent = (await env.repos.rules.getAll()).firstWhere((r) => r.id == id);
  });
  tearDown(() => env.close());

  Future<List<DateTime>> days(DateTime from, DateTime to) async {
    final ctx = await env.useCases.loadSchedule(from);
    return [
      for (final r in await env.repos.rules.getAll())
        ...const RecurrenceExpander().expand(r, from, to, ctx: ctx),
    ]..sort();
  }

  test(
    'switching off keeps the past and drops the future; on resumes',
    () async {
      await env.useCases.scheduleEditor.setEnabled(rent, enabled: false);
      final all = await days(DateTime(2026, 7, 1), DateTime(2027, 1, 31));
      expect(all.map((d) => d.month), [7, 8, 9, 10]);
      expect(
        all.last,
        DateTime(2026, 10, 15),
        reason: 'October was before today',
      );

      final off = (await env.repos.rules.getAll()).single;
      expect(off.isActive, isFalse);
      await env.useCases.scheduleEditor.setEnabled(off, enabled: true);
      final back = await days(DateTime(2026, 7, 1), DateTime(2027, 1, 31));
      expect(back, hasLength(7), reason: 'the pause never really happened');
    },
  );

  test('deleting ends the rule yesterday; it stays as history', () async {
    await env.useCases.scheduleEditor.delete(rent);
    final rules = await env.repos.rules.getAll();
    expect(rules.single.endDate, DateTime(2026, 10, 19));
    final all = await days(DateTime(2026, 7, 1), DateTime(2027, 1, 31));
    expect(all.map((d) => d.month), [7, 8, 9, 10]);
  });

  test('a rule that never ran is really deleted', () async {
    final id = await env.repos.rules.add(
      RecurringRule(
        title: 'Yeni',
        amount: 5,
        category: 'cafe',
        frequency: Frequency.daily,
        startDate: today,
      ),
    );
    final fresh = (await env.repos.rules.getAll()).firstWhere(
      (r) => r.id == id,
    );
    await env.useCases.scheduleEditor.delete(fresh);
    expect((await env.repos.rules.getAll()).map((r) => r.id), [rent.id]);
  });

  test(
    'editing splits the rule: old amount before, new amount after',
    () async {
      await env.useCases.reviseRule(
        rent,
        RuleEdit(
          title: 'Kredit',
          amount: 80,
          category: 'other',
          plan: RecurrencePlan.of(Frequency.monthly, DateTime(2026, 11, 15)),
          from: DateTime(2026, 11, 15),
        ),
      );
      final rules = await env.repos.rules.getAll()
        ..sort((a, b) => a.id!.compareTo(b.id!));
      expect(rules, hasLength(2));
      expect(rules.first.amount, 100);
      expect(rules.first.endDate, DateTime(2026, 11, 14));
      expect(rules.last.amount, 80);
      expect(rules.last.startDate, DateTime(2026, 11, 15));
      expect(rules.last.endDate, isNull);
    },
  );

  test('an edit cannot reach back before today; "ends on" is kept', () async {
    await env.useCases.reviseRule(
      rent,
      RuleEdit(
        title: 'Kredit',
        amount: 90,
        category: 'other',
        plan: RecurrencePlan(
          frequency: Frequency.monthly,
          weekdays: const {},
          end: EndsOn(DateTime(2027, 2, 15)),
        ),
        from: DateTime(2026, 9, 1),
      ),
    );
    final rules = await env.repos.rules.getAll()
      ..sort((a, b) => a.id!.compareTo(b.id!));
    expect(rules.first.endDate, DateTime(2026, 10, 19));
    expect(rules.last.startDate, today);
    expect(rules.last.endDate, DateTime(2027, 2, 15));
  });

  test('a rule that has not started yet is edited in place', () async {
    final id = await env.repos.rules.add(
      RecurringRule(
        title: 'Hovuz',
        amount: 10,
        category: 'other',
        frequency: Frequency.weekly,
        startDate: DateTime(2026, 10, 25),
      ),
    );
    final pool = (await env.repos.rules.getAll()).firstWhere((r) => r.id == id);
    await env.useCases.reviseRule(
      pool,
      RuleEdit(
        title: 'Hovuz',
        amount: 12,
        category: 'other',
        plan: RecurrencePlan.of(Frequency.weekly, DateTime(2026, 10, 25)),
        from: DateTime(2026, 10, 25),
      ),
    );
    final all = await env.repos.rules.getAll();
    expect(all, hasLength(2));
    expect(all.firstWhere((r) => r.id == id).amount, 12);
  });
}
