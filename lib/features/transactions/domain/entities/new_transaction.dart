import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction_kind.dart';

/// Everything the form collects. [repeat] turns it into a recurring rule too.
class NewTransaction extends Equatable {
  const NewTransaction({
    required this.kind,
    required this.amount,
    required this.category,
    required this.accountId,
    required this.date,
    required this.title,
    this.note,
    this.repeat,
  });

  final TransactionKind kind;
  final double amount;
  final String category;
  final int accountId;
  final DateTime date;

  /// Name used for the recurring rule (note, or the category label).
  final String title;
  final String? note;
  final Frequency? repeat;

  @override
  List<Object?> get props => [
    kind,
    amount,
    category,
    accountId,
    date,
    title,
    note,
    repeat,
  ];
}
