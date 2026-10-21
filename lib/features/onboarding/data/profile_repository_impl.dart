import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/features/home/data/mappers/account_mapper.dart';
import 'package:flux_wallet/features/home/data/mappers/recurring_rule_mapper.dart';
import 'package:flux_wallet/features/onboarding/data/onboarding_records.dart';
import 'package:flux_wallet/features/onboarding/domain/entities/onboarding_data.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._db);

  static const _nameKey = 'user_name';
  final AppDatabase _db;

  @override
  Future<String?> readName() async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.settings,
      where: 'key = ?',
      whereArgs: [_nameKey],
    );
    return rows.isEmpty ? null : rows.first['value'] as String;
  }

  @override
  Future<void> completeOnboarding(OnboardingData d, DateTime today) async {
    final db = await _db.instance;
    await db.transaction((txn) async {
      for (final a in initialAccounts(d)) {
        await txn.insert(Tables.accounts, a.toMap()..remove('id'));
      }
      if (d.hasSalary) {
        final rule = salaryRule(d, today).toMap()..remove('id');
        await txn.insert(Tables.recurringRules, rule);
      }
      await txn.insert(Tables.settings, {'key': _nameKey, 'value': d.name});
    });
  }
}
