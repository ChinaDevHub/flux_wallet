import 'package:flux_wallet/core/database/db_schema.dart';

/// Dates are stored as ISO strings (day key or full timestamp) so range
/// queries are plain lexicographic comparisons.
///
/// Version -> statements. Fresh installs run all of them in order.
const migrations = <int, List<String>>{
  1: schemaV1,
  2: [
    // A skipped occurrence of one rule ("Yalnız bu gün").
    '''
    CREATE TABLE rule_exceptions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      rule_id INTEGER NOT NULL REFERENCES recurring_rules(id) ON DELETE CASCADE,
      date TEXT NOT NULL,
      UNIQUE(rule_id, date)
    )''',
  ],
};
