import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/auth/data/pbkdf2_password_hasher.dart';

void main() {
  const hasher = Pbkdf2PasswordHasher(iterations: 1000);

  test('verifies the right password only', () async {
    final stored = await hasher.hash('correct horse');
    expect(await hasher.verify('correct horse', stored), isTrue);
    expect(await hasher.verify('correct horsf', stored), isFalse);
    expect(await hasher.verify('', stored), isFalse);
  });

  test('every hash has its own salt', () async {
    final a = await hasher.hash('same');
    final b = await hasher.hash('same');
    expect(a, isNot(b));
    expect(await hasher.verify('same', a), isTrue);
    expect(await hasher.verify('same', b), isTrue);
  });

  test('the stored text is self-describing', () async {
    final parts = (await hasher.hash('x')).split(r'$');
    expect(parts.length, 4);
    expect(parts[0], 'pbkdf2-sha256');
    expect(parts[1], '1000');
  });

  test('a hash made with another cost still verifies', () async {
    final old = await const Pbkdf2PasswordHasher(iterations: 500).hash('pw');
    expect(await hasher.verify('pw', old), isTrue);
  });

  test('malformed stored values never verify', () async {
    for (final bad in [
      '',
      'plain',
      'pbkdf2-sha256\$x\$a\$b',
      'md5\$1\$a\$b',
      'a\$b',
    ]) {
      expect(await hasher.verify('pw', bad), isFalse);
    }
  });
}
