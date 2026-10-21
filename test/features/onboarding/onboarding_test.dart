import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';
import 'package:flux_wallet/features/onboarding/domain/usecases/validate_onboarding.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flux_wallet/features/onboarding/presentation/cubit/onboarding_state.dart';

class _FakeProfile implements ProfileRepository {
  OnboardingData? saved;

  @override
  Future<String?> readName() async => saved?.name;

  @override
  Future<void> completeOnboarding(OnboardingData data, DateTime today) async =>
      saved = data;
}

void main() {
  group('validateOnboarding', () {
    OnboardingData? run({
      String name = 'Rauf',
      String card = '',
      String cash = '',
      String salary = '',
      String day = '',
    }) => validateOnboarding(
      name: name,
      card: card,
      cash: cash,
      salary: salary,
      salaryDay: day,
    );

    test('requires a name', () => expect(run(name: '  '), isNull));
    test('empty balances default to zero', () {
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

  test('cubit submits valid data and reports done', () async {
    final profile = _FakeProfile();
    final cubit = OnboardingCubit(profile, () => DateTime(2026, 10, 20));
    cubit.changed('name', 'Rauf');
    cubit.changed('card', '412');
    expect(cubit.state.canSubmit, isTrue);
    await cubit.submit();
    expect(cubit.state.status, OnboardingStatus.done);
    expect(profile.saved?.cardBalance, 412);
    await cubit.close();
  });

  test('cubit does not submit invalid form', () async {
    final profile = _FakeProfile();
    final cubit = OnboardingCubit(profile, () => DateTime(2026, 10, 20));
    await cubit.submit();
    expect(profile.saved, isNull);
    await cubit.close();
  });
}
