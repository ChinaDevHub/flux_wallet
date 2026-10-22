import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';

/// A pending item plus the planned bus fare it might replace that day.
class PendingView extends Equatable {
  const PendingView({required this.pending, this.replaceableBus});

  final PendingTransaction pending;
  final RecurringRule? replaceableBus;

  @override
  List<Object?> get props => [pending, replaceableBus];
}
