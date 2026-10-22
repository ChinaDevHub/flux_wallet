/// A transaction can belong to a debt (its opening and its payments), so
/// deleting the debt can take the money back out of the balance.
const schemaV5 = [
  'ALTER TABLE transactions ADD COLUMN debt_id '
      'INTEGER REFERENCES debts(id) ON DELETE SET NULL',
  'CREATE INDEX idx_transactions_debt ON transactions(debt_id)',
];
