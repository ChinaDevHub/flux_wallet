import 'package:equatable/equatable.dart';

/// How a day went against its limit: what was spent and what the limit was
/// on that day (the app's own daily budget, lowered by the user's cap).
class DayLimit extends Equatable {
  const DayLimit({required this.budget, required this.spent});

  static const _tolerance = 0.005;

  final double budget, spent;

  /// How far over the limit the day went (0 when it did not).
  double get over => spent - budget > _tolerance ? spent - budget : 0;

  bool get isOver => over > 0;

  /// 0..1, how much of the limit is used.
  double get used =>
      budget <= 0 ? (spent > 0 ? 1 : 0) : (spent / budget).clamp(0.0, 1.0);

  @override
  List<Object?> get props => [budget, spent];
}
