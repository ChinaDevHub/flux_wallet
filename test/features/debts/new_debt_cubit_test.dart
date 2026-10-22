import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_cubit.dart';
import 'package:flux_wallet/features/debts/presentation/cubit/new_debt_state.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import '../../support/test_env.dart';

void main() {
  final now = DateTime(2026, 10, 20, 9);
  late TestEnv env;
  late NewDebtCubit cubit;

  setUp(() async {
    env = await openTestEnv(now: now);
    await env.repos.onboarding.complete(
      const OnboardingData(cardBalance: 500, cashBalance: 0),
      now,
    );
    cubit = NewDebtCubit(
      env.useCases.createDebt,
      env.repos.accounts,
      () => now,
    );
    await cubit.init();
  });

  tearDown(() async {
    await cubit.close();
    await env.close();
  });

  test('starts today, on the first account, as a borrowed debt', () {
    expect(cubit.state.date, dateOnly(now));
    expect(cubit.state.account?.name, 'Kart');
    expect(cubit.state.direction, DebtDirection.borrowed);
    expect(cubit.state.canSubmit, isFalse);
  });

  test('a borrowed debt needs a due date, a lent one does not', () {
    cubit
      ..setPerson('Cuma')
      ..setAmount('30');
    expect(cubit.state.canSubmit, isFalse);
    cubit.setDue(DateTime(2026, 10, 25));
    expect(cubit.state.canSubmit, isTrue);
    cubit
      ..setDirection(DebtDirection.lent)
      ..setPerson('Fuad');
    expect(cubit.state.needsDueDate, isFalse);
  });

  test('moving the date past the due date drops the due date', () {
    cubit
      ..setDue(DateTime(2026, 10, 18))
      ..setDate(DateTime(2026, 10, 19));
    expect(cubit.state.dueDate, isNull);
    cubit
      ..setDue(DateTime(2026, 10, 25))
      ..setDate(DateTime(2026, 10, 10));
    expect(cubit.state.dueDate, DateTime(2026, 10, 25));
  });

  test('saving a debt from yesterday books yesterday\'s money', () async {
    cubit
      ..setDirection(DebtDirection.lent)
      ..setPerson('Fuad')
      ..setAmount('20')
      ..setDate(DateTime(2026, 10, 19));
    await cubit.submit();
    expect(cubit.state.status, DebtSaveStatus.done);
    expect((await env.repos.accounts.getAll()).first.balance, 480);
    final tx = (await env.repos.transactions.getBetween(
      DateTime(2026),
      DateTime(2027),
    )).single;
    expect(tx.date, DateTime(2026, 10, 19, 12));
  });
}
