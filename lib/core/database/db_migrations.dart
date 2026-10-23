import 'package:flux_wallet/core/database/db_schema_v1.dart';
import 'package:flux_wallet/core/database/db_schema_v3.dart';
import 'package:flux_wallet/core/database/db_schema_v4.dart';
import 'package:flux_wallet/core/database/db_schema_v5.dart';
import 'package:flux_wallet/core/database/db_schema_v6.dart';

/// Dates are stored as ISO strings (day key or full timestamp) so range
/// queries are plain lexicographic comparisons.
///
/// Version -> statements. Fresh installs run all of them in order.
final migrations = <int, List<String>>{
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
  3: schemaV3,
  4: schemaV4,
  5: schemaV5,
  6: schemaV6,
};
