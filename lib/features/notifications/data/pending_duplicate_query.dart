import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/bank_message_parser.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/merchant_key.dart';
import 'package:sqflite/sqflite.dart' show Database;

/// Same fingerprint, or same amount within [window] whose merchant names
/// share a word (a bank app says "BOLT.EU", its SMS says "ABB: BOLT.EU").
Future<bool> pendingExists(
  Database db,
  UserScope scope,
  PendingTransaction c,
  Duration window,
) async {
  final rows = await db.query(
    Tables.pendingNotifications,
    columns: ['fingerprint', 'merchant'],
    where: scope.where(
      'fingerprint = ? OR (amount = ? AND occurred_at BETWEEN ? AND ?)',
    ),
    whereArgs: scope.args([
      c.fingerprint,
      c.amount,
      c.occurredAt.subtract(window).toIso8601String(),
      c.occurredAt.add(window).toIso8601String(),
    ]),
  );
  final mine = merchantKey(c.merchant).split(' ').toSet();
  return rows.any((r) {
    if (r['fingerprint'] == c.fingerprint) return true;
    final other = r['merchant'] as String;
    if (other == BankMessageParser.unknownMerchant) return true;
    return merchantKey(other).split(' ').any(mine.contains);
  });
}
