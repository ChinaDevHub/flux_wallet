/// A reference to another table's row; [optional] ones may be null.
class BackupRef {
  const BackupRef(this.table, {this.optional = false});

  final String table;
  final bool optional;
}

/// Foreign keys inside a backup: table -> column -> what it points to.
/// Ids are renumbered on import, so these references are rewritten too.
const backupRelations = <String, Map<String, BackupRef>>{
  'transactions': {
    'account_id': BackupRef('accounts'),
    'debt_id': BackupRef('debts', optional: true),
  },
  'rule_exceptions': {'rule_id': BackupRef('recurring_rules')},
  'debt_payments': {'debt_id': BackupRef('debts')},
};
