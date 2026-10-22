abstract interface class BackupRepository {
  /// Every table as one JSON document.
  Future<String> exportJson(DateTime exportedAt);

  /// Replaces all data with the backup's; throws `BackupException` when the
  /// text is not a valid backup (and then changes nothing).
  Future<void> importJson(String json);
}
