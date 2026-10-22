import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

enum PendingStatus { pending, confirmed, dismissed }

/// A parsed bank message waiting for the user's "Təsdiqlə".
class PendingTransaction extends Equatable {
  const PendingTransaction({
    this.id,
    required this.fingerprint,
    required this.rawText,
    required this.merchant,
    required this.amount,
    required this.type,
    required this.occurredAt,
    this.category,
    this.status = PendingStatus.pending,
  });

  final int? id;
  final String fingerprint, rawText, merchant;
  final double amount;
  final TxType type;
  final DateTime occurredAt;

  /// Suggested from the merchant memory / built-in hints.
  final String? category;
  final PendingStatus status;

  @override
  List<Object?> get props => [
    id,
    fingerprint,
    rawText,
    merchant,
    amount,
    type,
    occurredAt,
    category,
    status,
  ];
}
