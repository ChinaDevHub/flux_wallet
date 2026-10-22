import 'package:equatable/equatable.dart';

class OnboardingData extends Equatable {
  const OnboardingData({
    required this.cardBalance,
    required this.cashBalance,
    this.salaryAmount,
    this.salaryDay,
  });

  final double cardBalance;
  final double cashBalance;
  final double? salaryAmount;
  final int? salaryDay;

  bool get hasSalary => (salaryAmount ?? 0) > 0 && salaryDay != null;

  @override
  List<Object?> get props => [
    cardBalance,
    cashBalance,
    salaryAmount,
    salaryDay,
  ];
}
