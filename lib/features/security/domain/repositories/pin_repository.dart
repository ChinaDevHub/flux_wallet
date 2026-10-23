import 'package:flux_wallet/features/security/domain/entities/stored_pin.dart';

/// The signed-in user's PIN record.
abstract interface class PinRepository {
  /// Null when no PIN is set. Throws `StateError` when nobody is signed in.
  Future<StoredPin?> current();
  Future<void> save(StoredPin pin);
  Future<void> clear();
}
