import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:cryptography/helpers.dart';
import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';

/// PBKDF2-HMAC-SHA256 with a random salt per password. The stored text
/// `pbkdf2-sha256$<iterations>$<salt>$<hash>` carries everything needed to
/// verify later, so the cost can be raised without breaking old accounts.
/// The work runs in a separate isolate: it takes a few hundred milliseconds.
class Pbkdf2PasswordHasher implements PasswordHasher {
  const Pbkdf2PasswordHasher({this.iterations = 100000});

  static const _prefix = 'pbkdf2-sha256';
  final int iterations;

  @override
  Future<String> hash(String password) async {
    final salt = List<int>.generate(16, (_) => Random.secure().nextInt(256));
    final derived = await _derive(password, salt, iterations);
    return '$_prefix\$$iterations\$${base64.encode(salt)}\$${base64.encode(derived)}';
  }

  @override
  Future<bool> verify(String password, String stored) async {
    final parts = stored.split(r'$');
    if (parts.length != 4 || parts[0] != _prefix) return false;
    final count = int.tryParse(parts[1]);
    if (count == null) return false;
    final derived = await _derive(password, base64.decode(parts[2]), count);
    return constantTimeBytesEquality.equals(derived, base64.decode(parts[3]));
  }

  Future<List<int>> _derive(String password, List<int> salt, int count) =>
      Isolate.run(() async {
        final algorithm = Pbkdf2(
          macAlgorithm: Hmac.sha256(),
          iterations: count,
          bits: 256,
        );
        final key = await algorithm.deriveKeyFromPassword(
          password: password,
          nonce: salt,
        );
        return key.extractBytes();
      });
}
