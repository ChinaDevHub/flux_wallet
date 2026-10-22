import 'package:flux_wallet/core/database/db_schema.dart';

/// Tables whose uniqueness must become per user are rebuilt (SQLite cannot
/// change a constraint in place); their old rows are copied across.
const rebuildPerUserTables = [
  'ALTER TABLE day_flags RENAME TO day_flags_old',
  '''
  CREATE TABLE day_flags(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    $ownerColumn,
    date TEXT NOT NULL,
    is_not_working_day INTEGER NOT NULL,
    UNIQUE(user_id, date)
  )''',
  'INSERT INTO day_flags(id, date, is_not_working_day) '
      'SELECT id, date, is_not_working_day FROM day_flags_old',
  'DROP TABLE day_flags_old',
  'ALTER TABLE merchant_mappings RENAME TO merchant_mappings_old',
  '''
  CREATE TABLE merchant_mappings(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    $ownerColumn,
    merchant_key TEXT NOT NULL,
    category TEXT NOT NULL,
    UNIQUE(user_id, merchant_key)
  )''',
  'INSERT INTO merchant_mappings(merchant_key, category) '
      'SELECT merchant_key, category FROM merchant_mappings_old',
  'DROP TABLE merchant_mappings_old',
  'ALTER TABLE pending_notifications RENAME TO pending_notifications_old',
  '''
  CREATE TABLE pending_notifications(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    $ownerColumn,
    fingerprint TEXT NOT NULL,
    raw_text TEXT NOT NULL,
    merchant TEXT NOT NULL,
    amount REAL NOT NULL,
    type TEXT NOT NULL,
    occurred_at TEXT NOT NULL,
    category TEXT,
    status TEXT NOT NULL DEFAULT 'pending',
    UNIQUE(user_id, fingerprint)
  )''',
  'INSERT INTO pending_notifications(id, fingerprint, raw_text, merchant, '
      'amount, type, occurred_at, category, status) '
      'SELECT id, fingerprint, raw_text, merchant, amount, type, occurred_at, '
      'category, status FROM pending_notifications_old',
  'DROP TABLE pending_notifications_old',
];
