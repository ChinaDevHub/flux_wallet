import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/settings/data/backup_restore.dart';
import 'package:flux_wallet/features/settings/domain/repositories/data_reset_repository.dart';

class DataResetRepositoryImpl implements DataResetRepository {
  const DataResetRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<void> wipe() =>
      _db.write((db) => db.transaction((txn) => clearUserData(txn, _scope)));
}
