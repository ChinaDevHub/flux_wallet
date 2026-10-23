import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/session/user_scope.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/rules/domain/entities/pause_range.dart';
import 'package:flux_wallet/features/rules/domain/repositories/rule_pause_repository.dart';

class RulePauseRepositoryImpl implements RulePauseRepository {
  const RulePauseRepositoryImpl(this._db, this._scope);

  final AppDatabase _db;
  final UserScope _scope;

  @override
  Future<Map<int, List<PauseRange>>> getFrom(DateTime from) async {
    final db = await _db.instance;
    final rows = await db.query(
      Tables.rulePauses,
      where: _scope.where('(to_date IS NULL OR to_date >= ?)'),
      whereArgs: _scope.args([dayKey(from)]),
    );
    final result = <int, List<PauseRange>>{};
    for (final r in rows) {
      final to = r['to_date'] as String?;
      (result[r['rule_id'] as int] ??= []).add(
        PauseRange(
          DateTime.parse(r['from_date'] as String),
          to == null ? null : DateTime.parse(to),
        ),
      );
    }
    return result;
  }
}
