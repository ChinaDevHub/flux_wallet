/// The phone side of backups: sharing a file out and picking one in.
abstract interface class BackupGateway {
  Future<void> shareFile(String fileName, String contents);

  /// The text of the file the user picked, or null when they cancelled.
  Future<String?> pickFile();
}
