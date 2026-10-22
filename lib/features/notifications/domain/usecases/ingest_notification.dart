import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/bank_message_parser.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/suggest_category.dart';

/// Raw notification -> parsed -> pending queue. Nothing is booked here.
class IngestNotification {
  const IngestNotification(this._pending, this._suggest);

  static const _parser = BankMessageParser();

  final PendingRepository _pending;
  final SuggestCategory _suggest;

  /// True when a new pending item was queued.
  Future<bool> call(RawNotification raw) async {
    final parsed = _parser(raw.text, raw.receivedAt);
    if (parsed == null) return false;
    final item = PendingTransaction(
      fingerprint: '${raw.receivedAt.millisecondsSinceEpoch}|${raw.text}',
      rawText: raw.text,
      merchant: parsed.merchant,
      amount: parsed.amount,
      type: parsed.type,
      occurredAt: parsed.occurredAt ?? raw.receivedAt,
      category: await _suggest(parsed.merchant),
    );
    if (await _pending.isDuplicate(item)) return false;
    await _pending.add(item);
    return true;
  }
}
