import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

class ParsedBankMessage extends Equatable {
  const ParsedBankMessage({
    required this.amount,
    required this.merchant,
    required this.type,
    this.occurredAt,
  });

  final double amount;
  final String merchant;
  final TxType type;

  /// Null when the text carries no date; callers fall back to arrival time.
  final DateTime? occurredAt;

  @override
  List<Object?> get props => [amount, merchant, type, occurredAt];
}
