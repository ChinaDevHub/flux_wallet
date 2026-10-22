/// Who is signed in. Every repository reads this before touching user data.
abstract interface class CurrentUser {
  /// Throws [StateError] when nobody is signed in.
  String get id;
}
