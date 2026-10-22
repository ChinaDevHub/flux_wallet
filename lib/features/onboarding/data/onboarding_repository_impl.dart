import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/features/onboarding/data/onboarding_records.dart';
import 'package:flux_wallet/features/rules/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/transactions/data/mappers/account_mapper.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<bool> isCompleted() async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.accounts,
      columns: ['id'],
      where: _scope.where(),
      whereArgs: _scope.args(),
      limit: 1,
    );
    return rows.isNotEmpty;
  }

  @override
  Future<void> complete(OnboardingData d, DateTime today) => _db.write(
    (db) => db.transaction((txn) async {
      for (final a in initialAccounts(d)) {
        await txn.insert(
          Tables.accounts,
          _scope.stamp(a.toMap()..remove('id')),
        );
      }
      if (d.hasSalary) {
        final rule = salaryRule(d, today).toMap()..remove('id');
        await txn.insert(Tables.recurringRules, _scope.stamp(rule));
      }
    }),
  );
}
