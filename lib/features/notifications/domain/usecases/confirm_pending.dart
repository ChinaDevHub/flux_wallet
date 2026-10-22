import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_view.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/merchant_repository.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/booked_transaction.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/merchant_key.dart';
import 'package:flux_wallet/features/rules/domain/usecases/rule_schedule_editor.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/transaction_repository.dart';

/// "Təsdiqlə": books the transaction and applies the user's choices.
class ConfirmPending {
  const ConfirmPending(
    this._pending,
    this._transactions,
    this._merchants,
    this._accounts,
    this._editor,
  );

  final PendingRepository _pending;
  final TransactionRepository _transactions;
  final MerchantRepository _merchants;
  final AccountRepository _accounts;
  final RuleScheduleEditor _editor;

  Future<void> call(
    PendingView view, {
    required String category,
    bool replaceBus = false,
    bool remember = false,
  }) async {
    final p = view.pending;
    final account = (await _accounts.getAll()).bankCard;
    await _transactions.add(bookedTransaction(p, category, account.id!));
    final bus = view.replaceableBus;
    // The taxi took the bus fare's place: drop that day's planned fare.
    if (replaceBus && bus != null) {
      await _editor.skipOnce(bus, dateOnly(p.occurredAt));
    }
    if (remember) await _merchants.remember(merchantKey(p.merchant), category);
    await _pending.setStatus(p.id!, PendingStatus.confirmed);
  }

  Future<void> dismiss(PendingView view) =>
      _pending.setStatus(view.pending.id!, PendingStatus.dismissed);
}
