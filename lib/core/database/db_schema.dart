abstract final class Tables {
  static const users = 'users';
  static const accounts = 'accounts';
  static const transactions = 'transactions';
  static const recurringRules = 'recurring_rules';
  static const dayFlags = 'day_flags';
  static const ruleExceptions = 'rule_exceptions';
  static const settings = 'settings';
  static const pendingNotifications = 'pending_notifications';
  static const merchantMappings = 'merchant_mappings';
  static const debts = 'debts';
  static const debtPayments = 'debt_payments';

  /// Tables that belong to one user (they all have a `user_id`), parents
  /// before children. `settings` is per device and `users` is the owner.
  static const userData = [
    accounts,
    recurringRules,
    debts,
    transactions,
    dayFlags,
    ruleExceptions,
    pendingNotifications,
    merchantMappings,
    debtPayments,
  ];
}

/// Column added to everything a user owns.
const ownerColumn = 'user_id TEXT REFERENCES users(id) ON DELETE CASCADE';
