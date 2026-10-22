import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flux_wallet/features/onboarding/domain/usecases/validate_onboarding.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_state.dart';

class _FakeOnboarding implements OnboardingRepository {
  OnboardingData? saved;

  @override
  Future<bool> isCompleted() async => saved != null;

  @override
  Future<void> complete(OnboardingData data, DateTime today) async =>
      saved = data;
}

void main() {
  group('validateOnboarding', () {
    OnboardingData? run({
      String card = '',
      String cash = '',
      String salary = '',
      String day = '',
    }) => validateOnboarding(
      card: card,
      cash: cash,
      salary: salary,
      salaryDay: day,
    );

    test('an empty form is valid: balances default to zero', () {
      final d = run()!;
      expect([d.cardBalance, d.cashBalance, d.hasSalary], [0, 0, false]);
    });
    test(
      'accepts comma decimals',
      () => expect(run(card: '12,5')!.cardBalance, 12.5),
    );
    test('salary needs a valid day', () {
      expect(run(salary: '1200'), isNull);
      expect(run(salary: '1200', day: '32'), isNull);
      expect(run(salary: '1200', day: '29')!.hasSalary, isTrue);
    });
    test('rejects negative balances', () => expect(run(card: '-5'), isNull));
  });

  test('cubit starts submittable and saves what was typed', () async {
    final repo = _FakeOnboarding();
    final cubit = OnboardingCubit(repo, () => DateTime(2026, 10, 20));
    expect(cubit.state.canSubmit, isTrue);
    cubit.changed('card', '412');
    await cubit.submit();
    expect(cubit.state.status, OnboardingStatus.done);
    expect(repo.saved?.cardBalance, 412);
    await cubit.close();
  });

  test('cubit does not submit an invalid form', () async {
    final repo = _FakeOnboarding();
    final cubit = OnboardingCubit(repo, () => DateTime(2026, 10, 20));
    cubit.changed('card', '-1');
    expect(cubit.state.canSubmit, isFalse);
    await cubit.submit();
    expect(repo.saved, isNull);
    await cubit.close();
  });
}
