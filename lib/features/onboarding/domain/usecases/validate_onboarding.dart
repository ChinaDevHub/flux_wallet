import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';

/// Builds [OnboardingData] from raw form text, or null when invalid.
OnboardingData? validateOnboarding({
  required String name,
  required String card,
  required String cash,
  required String salary,
  required String salaryDay,
}) {
  final cleanName = name.trim();
  final cardValue = card.trim().isEmpty ? 0.0 : parseMoney(card);
  final cashValue = cash.trim().isEmpty ? 0.0 : parseMoney(cash);
  final salaryValue = salary.trim().isEmpty ? null : parseMoney(salary);
  final day = int.tryParse(salaryDay.trim());
  if (cleanName.isEmpty || cardValue == null || cashValue == null) return null;
  if (cardValue < 0 || cashValue < 0) return null;
  if (salary.trim().isNotEmpty && (salaryValue == null || salaryValue <= 0)) {
    return null;
  }
  if (salaryValue != null && (day == null || day < 1 || day > 31)) return null;
  return OnboardingData(
    name: cleanName,
    cardBalance: cardValue,
    cashBalance: cashValue,
    salaryAmount: salaryValue,
    salaryDay: salaryValue == null ? null : day,
  );
}
