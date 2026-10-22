/// The sign-in state of this device.
abstract interface class Session {
  /// The signed-in user id; null when signed out.
  String? get activeId;

  /// Reads the persisted id once at start-up.
  Future<String?> restore();
  Future<void> signIn(String userId);
  Future<void> signOut();
}
