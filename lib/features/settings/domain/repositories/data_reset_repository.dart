abstract interface class DataResetRepository {
  /// Deletes the signed-in user's money data (accounts, transactions, rules,
  /// debts, bank messages, ...) in one step. The account, password and PIN
  /// stay.
  Future<void> wipe();
}
