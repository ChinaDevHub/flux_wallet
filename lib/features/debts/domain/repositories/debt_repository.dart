import 'package:flux_wallet/features/debts/domain/entities/debt.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_payment.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

abstract interface class DebtRepository {
  /// Open debts first, soonest due date first.
  Future<List<DebtSummary>> getAll();
  Future<int> add(Debt debt);
  Future<void> delete(int id);

  /// Stores the payment and its [transaction] together, closing the debt
  /// when nothing is left, all in one database transaction.
  Future<void> recordPayment(DebtPayment payment, Transaction transaction);
}
