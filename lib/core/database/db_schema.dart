abstract final class Tables {
  static const accounts = 'accounts';
  static const transactions = 'transactions';
  static const recurringRules = 'recurring_rules';
  static const dayFlags = 'day_flags';
  static const ruleExceptions = 'rule_exceptions';
  static const settings = 'settings';
}

const schemaV1 = [
  '''
  CREATE TABLE accounts(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    balance REAL NOT NULL,
    type TEXT NOT NULL
  )''',
  '''
  CREATE TABLE transactions(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    amount REAL NOT NULL,
    type TEXT NOT NULL,
    category TEXT NOT NULL,
    account_id INTEGER NOT NULL REFERENCES accounts(id),
    date TEXT NOT NULL,
    source TEXT NOT NULL,
    note TEXT
  )''',
  'CREATE INDEX idx_transactions_date ON transactions(date)',
  '''
  CREATE TABLE recurring_rules(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    amount REAL NOT NULL,
    category TEXT NOT NULL,
    type TEXT NOT NULL,
    frequency TEXT NOT NULL,
    start_date TEXT NOT NULL,
    end_date TEXT,
    is_active INTEGER NOT NULL DEFAULT 1
  )''',
  '''
  CREATE TABLE day_flags(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    date TEXT NOT NULL UNIQUE,
    is_not_working_day INTEGER NOT NULL
  )''',
  'CREATE TABLE settings(key TEXT PRIMARY KEY, value TEXT NOT NULL)',
];
