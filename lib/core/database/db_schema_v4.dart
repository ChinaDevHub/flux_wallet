import 'package:flux_wallet/core/database/db_schema.dart';
import 'package:flux_wallet/core/database/db_schema_v4_rebuilds.dart';

/// Plain tables only get a nullable column: SQLite cannot add a NOT NULL
/// foreign key later. The app always writes it; old rows are adopted by the
/// first user who registers.
final _addUserId = [
  for (final t in [
    Tables.accounts,
    Tables.transactions,
    Tables.recurringRules,
    Tables.ruleExceptions,
    Tables.debts,
    Tables.debtPayments,
  ])
    'ALTER TABLE $t ADD COLUMN $ownerColumn',
];

const _v4UserTables = [
  Tables.accounts,
  Tables.recurringRules,
  Tables.debts,
  Tables.transactions,
  Tables.dayFlags,
  Tables.ruleExceptions,
  Tables.pendingNotifications,
  Tables.merchantMappings,
  Tables.debtPayments,
];

/// Multi-user: the `users` table, and `user_id` on everything a user owns.
final schemaV4 = [
  '''
  CREATE TABLE users(
    id TEXT PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    password_hint TEXT,
    full_name TEXT NOT NULL,
    avatar_url TEXT,
    created_at TEXT NOT NULL
  )''',
  ..._addUserId,
  ...rebuildPerUserTables,
  // The per-user tables as they stood at v4 (later ones index themselves).
  for (final t in _v4UserTables) 'CREATE INDEX idx_${t}_user ON $t(user_id)',
];
