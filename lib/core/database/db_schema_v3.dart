/// Bank notification queue, merchant memory and debts.
const schemaV3 = [
  '''
  CREATE TABLE pending_notifications(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fingerprint TEXT NOT NULL UNIQUE,
    raw_text TEXT NOT NULL,
    merchant TEXT NOT NULL,
    amount REAL NOT NULL,
    type TEXT NOT NULL,
    occurred_at TEXT NOT NULL,
    category TEXT,
    status TEXT NOT NULL DEFAULT 'pending'
  )''',
  'CREATE TABLE merchant_mappings(merchant_key TEXT PRIMARY KEY, category TEXT NOT NULL)',
  '''
  CREATE TABLE debts(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    person TEXT NOT NULL,
    amount REAL NOT NULL,
    direction TEXT NOT NULL,
    due_date TEXT,
    note TEXT,
    created_at TEXT NOT NULL,
    is_closed INTEGER NOT NULL DEFAULT 0
  )''',
  '''
  CREATE TABLE debt_payments(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    debt_id INTEGER NOT NULL REFERENCES debts(id) ON DELETE CASCADE,
    amount REAL NOT NULL,
    date TEXT NOT NULL
  )''',
];
