/// Foreign keys inside a backup: table -> column -> table it points to.
/// Ids are renumbered on import, so these references are rewritten too.
const backupRelations = <String, Map<String, String>>{
  'transactions': {'account_id': 'accounts'},
  'rule_exceptions': {'rule_id': 'recurring_rules'},
  'debt_payments': {'debt_id': 'debts'},
};
