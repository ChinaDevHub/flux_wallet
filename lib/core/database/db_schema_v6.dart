/// Rules can pick their weekdays and pause in some months; a user can lock
/// the app with a PIN (hashed like the password, never stored in plain).
const schemaV6 = [
  'ALTER TABLE recurring_rules ADD COLUMN weekday_mask INTEGER',
  'ALTER TABLE recurring_rules ADD COLUMN skip_month_mask '
      'INTEGER NOT NULL DEFAULT 0',
  'ALTER TABLE users ADD COLUMN pin_hash TEXT',
  'ALTER TABLE users ADD COLUMN pin_length INTEGER',
];
