import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:sqflite/sqflite.dart';

/// The date of the user's oldest transaction, or null when there is none.
Future<DateTime?> selectEarliestDate(Database db, UserScope scope) async {
  final rows = await db.rawQuery(
    'SELECT MIN(date) AS first FROM ${Tables.transactions} '
    'WHERE ${scope.where()}',
    scope.args(),
  );
  final first = rows.first['first'] as String?;
  return first == null ? null : DateTime.parse(first);
}
