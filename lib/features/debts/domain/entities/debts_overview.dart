import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_direction.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

class DebtsOverview extends Equatable {
  const DebtsOverview(this.all);

  final List<DebtSummary> all;

  List<DebtSummary> open(DebtDirection d) =>
      all.where((s) => s.debt.direction == d && !s.debt.isClosed).toList();

  List<DebtSummary> closed(DebtDirection d) =>
      all.where((s) => s.debt.direction == d && s.debt.isClosed).toList();

  /// Money still to be paid back (borrowed) or to come back (lent).
  double total(DebtDirection d) =>
      open(d).fold(0.0, (sum, s) => sum + s.remaining);

  @override
  List<Object?> get props => [all];
}
