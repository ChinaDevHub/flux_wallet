import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/transactions/data/mappers/account_mapper.dart';
import 'package:flux_wallet/features/transactions/domain/entities/account.dart';
import 'package:flux_wallet/features/transactions/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  const AccountRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<List<Account>> getAll() async {
    final db = await _db.instance;
    return (await db.query(
      Tables.accounts,
      where: _scope.where(),
      whereArgs: _scope.args(),
      orderBy: 'id',
    )).map(accountFromMap).toList();
  }

  @override
  Future<int> add(Account account) => _db.write(
    (db) =>
        db.insert(Tables.accounts, _scope.stamp(account.toMap()..remove('id'))),
  );
}
