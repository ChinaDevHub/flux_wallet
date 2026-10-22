abstract interface class PasswordHasher {
  /// A salted, self-describing hash; the plain password is never stored.
  Future<String> hash(String password);
  Future<bool> verify(String password, String stored);
}
