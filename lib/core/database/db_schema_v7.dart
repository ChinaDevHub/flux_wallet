import 'package:flux_wallet/core/database/db_schema.dart';

/// Turns every switched-off rule into an open pause from its first day (a
/// pause keeps the days before it, which `is_active = 0` could not).
const backfillRulePauses =
    'INSERT INTO ${Tables.rulePauses}(user_id, rule_id, from_date) '
    'SELECT user_id, id, start_date FROM ${Tables.recurringRules} r '
    'WHERE r.is_active = 0 AND NOT EXISTS '
    '(SELECT 1 FROM ${Tables.rulePauses} p WHERE p.rule_id = r.id)';

/// The same for one user's rules, after a backup made before pauses existed.
const backfillUserRulePauses = '$backfillRulePauses AND r.user_id = ?';

/// A rule can be switched off for a stretch of days (from..to, open-ended
/// while still off) and back on, without rewriting the days it did run.
const schemaV7 = [
  '''
  CREATE TABLE ${Tables.rulePauses}(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    $ownerColumn,
    rule_id INTEGER NOT NULL REFERENCES recurring_rules(id) ON DELETE CASCADE,
    from_date TEXT NOT NULL,
    to_date TEXT
  )''',
  'CREATE INDEX idx_rule_pauses_rule ON ${Tables.rulePauses}(rule_id)',
  'CREATE INDEX idx_rule_pauses_user ON ${Tables.rulePauses}(user_id)',
  backfillRulePauses,
];
