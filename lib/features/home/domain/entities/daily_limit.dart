import 'package:equatable/equatable.dart';

class DailyLimit extends Equatable {
  const DailyLimit({
    required this.totalBalance,
    required this.obligations,
    required this.daysLeft,
    required this.nextIncome,
  });

  final double totalBalance;
  final double obligations;
  final int daysLeft;
  final DateTime nextIncome;

  /// Sərbəst pul = balans - məcburi xərclər.
  double get freeMoney => totalBalance - obligations;

  /// Məcburi xərclərə çatmayan məbləğ (0 if covered).
  double get shortfall => freeMoney < 0 ? -freeMoney : 0;

  bool get hasShortfall => shortfall > 0;

  @override
  List<Object?> get props => [totalBalance, obligations, daysLeft, nextIncome];
}
