import 'package:flux_wallet/features/security/domain/entities/lock_attempts.dart';

/// Where the wrong-PIN count and the wait survive app restarts.
abstract interface class PinAttemptsStore {
  Future<LockAttempts> read();
  Future<void> save(LockAttempts attempts);
  Future<void> clear();
}
