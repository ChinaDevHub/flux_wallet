import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/security/domain/entities/stored_pin.dart';
import 'package:flux_wallet/features/security/domain/repositories/pin_repository.dart';

/// The PIN lives on the user's own row, so each roommate has their own.
class PinRepositoryImpl implements PinRepository {
  const PinRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<StoredPin?> current() async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.users,
      columns: ['pin_hash', 'pin_length'],
      where: 'id = ?',
      whereArgs: [_scope.id],
    );
    final hash = rows.firstOrNull?['pin_hash'] as String?;
    if (hash == null) return null;
    return StoredPin(hash: hash, length: rows.first['pin_length'] as int);
  }

  @override
  Future<void> save(StoredPin pin) =>
      _write({'pin_hash': pin.hash, 'pin_length': pin.length});

  @override
  Future<void> clear() => _write({'pin_hash': null, 'pin_length': null});

  Future<void> _write(Map<String, Object?> values) => _db.write(
    (db) => db.update(
      Tables.users,
      values,
      where: 'id = ?',
      whereArgs: [_scope.id],
    ),
  );
}
