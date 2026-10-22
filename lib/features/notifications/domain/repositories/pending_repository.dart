import 'package:flux_wallet/features/notifications/domain/entities/pending_transaction.dart';

abstract interface class PendingRepository {
  Future<List<PendingTransaction>> getPending();
  Future<int> countPending();

  /// Same fingerprint, or same merchant + amount within a few minutes (a bank
  /// app and an SMS often announce the same payment).
  Future<bool> isDuplicate(PendingTransaction candidate);
  Future<int> add(PendingTransaction pending);
  Future<void> setStatus(int id, PendingStatus status);
}
