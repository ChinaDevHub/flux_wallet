import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/merchant_repository.dart';
import 'package:sqflite/sqflite.dart' show ConflictAlgorithm;

class MerchantRepositoryImpl implements MerchantRepository {
  const MerchantRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<String?> categoryFor(String merchantKey) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.merchantMappings,
      where: _scope.where('merchant_key = ?'),
      whereArgs: _scope.args([merchantKey]),
    );
    return rows.isEmpty ? null : rows.first['category'] as String;
  }

  @override
  Future<void> remember(String merchantKey, String category) => _db.write(
    (db) => db.insert(
      Tables.merchantMappings,
      _scope.stamp({'merchant_key': merchantKey, 'category': category}),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ),
  );
}
