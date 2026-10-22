import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:sqflite/sqflite.dart' show DatabaseExecutor;

/// Before accounts existed the app was single-user and its rows have no owner.
/// The first account that registers takes them over, so nothing is lost.
Future<void> adoptOrphanedRows(DatabaseExecutor txn, String userId) async {
  for (final table in Tables.userData) {
    await txn.update(table, {'user_id': userId}, where: 'user_id IS NULL');
  }
}
