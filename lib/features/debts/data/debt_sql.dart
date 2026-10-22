import 'package:flux_wallet/core/database/db_schema.dart';

/// Debts with what was paid so far; open ones first, soonest due first.
/// Argument: the user id.
const selectDebtSummaries =
    '''
  SELECT d.*, COALESCE(SUM(p.amount), 0) AS paid
  FROM ${Tables.debts} d
  LEFT JOIN ${Tables.debtPayments} p ON p.debt_id = d.id
  WHERE d.user_id = ?
  GROUP BY d.id
  ORDER BY d.is_closed, d.due_date IS NULL, d.due_date, d.id''';

/// Closes the debt once nothing is left to pay. Arguments: id, id, user id.
const closeIfSettled =
    '''
  UPDATE ${Tables.debts} SET is_closed = 1
  WHERE id = ? AND user_id = ? AND amount -
    (SELECT SUM(amount) FROM ${Tables.debtPayments} WHERE debt_id = ?) < 0.005''';
