import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/notifications/data/pending_duplicate_query.dart';
import 'package:flux_wallet/features/notifications/data/pending_notification_mapper.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/pending_repository.dart';

class PendingRepositoryImpl implements PendingRepository {
  const PendingRepositoryImpl(this._db, this._scope);

  /// Two messages this close about the same payment are one payment.
  static const _window = Duration(minutes: 10);
  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<List<PendingTransaction>> getPending() async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.pendingNotifications,
      where: _scope.where('status = ?'),
      whereArgs: _scope.args([PendingStatus.pending.name]),
      orderBy: 'occurred_at DESC',
    );
    return rows.map(pendingFromMap).toList();
  }

  @override
  Future<int> countPending() async => (await getPending()).length;

  @override
  Future<bool> isDuplicate(PendingTransaction c) async =>
      pendingExists(await _db.instance, _scope, c, _window);

  @override
  Future<int> add(PendingTransaction p) => _db.write(
    (db) => db.insert(Tables.pendingNotifications, _scope.stamp(p.toMap())),
  );

  @override
  Future<void> setStatus(int id, PendingStatus status) => _db.write(
    (db) => db.update(
      Tables.pendingNotifications,
      {'status': status.name},
      where: _scope.where('id = ?'),
      whereArgs: _scope.args([id]),
    ),
  );
}
