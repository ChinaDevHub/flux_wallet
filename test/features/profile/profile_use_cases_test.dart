import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/auth/domain/entities/auth_exception.dart';
import 'package:flux_wallet/features/profile/domain/entities/avatar.dart';
import 'package:flux_wallet/features/profile/domain/entities/profile_edit.dart';
import 'package:flux_wallet/features/profile/domain/repositories/avatar_picker.dart';
import 'package:flux_wallet/features/profile/domain/usecases/set_avatar.dart';
import '../../support/test_env.dart';

class _Picker implements AvatarPicker {
  String? next;
  final discarded = <String>[];

  @override
  Future<String?> pickFromGallery(String userId) async => next;

  @override
  Future<void> discard(String avatarUrl) async => discarded.add(avatarUrl);
}

void main() {
  late TestEnv env;

  Future<AuthFailure?> failureOf(Future<Object?> Function() action) async {
    try {
      await action();
    } on AuthException catch (e) {
      return e.failure;
    }
    return null;
  }

  setUp(() async => env = await openTestEnv());
  tearDown(() => env.close());

  group('update profile', () {
    test(
      'saves name, username and hint for the signed-in user at once',
      () async {
        await env.useCases.updateProfile(
          const ProfileEdit(
            fullName: '  Rauf Əliyev ',
            username: ' Rauf.A ',
            hint: ' my cat ',
          ),
        );
        final user = (await env.repos.users.current())!;
        expect(
          [user.fullName, user.username, user.passwordHint],
          ['Rauf Əliyev', 'rauf.a', 'my cat'],
        );
        expect((await env.repos.users.byUsername('rauf.a'))?.id, env.userId);
        expect(await env.repos.users.byUsername('tester'), isNull);
      },
    );

    test('an empty hint clears it', () async {
      await env.useCases.updateProfile(
        const ProfileEdit(fullName: 'Rauf', username: 'tester', hint: 'x'),
      );
      await env.useCases.updateProfile(
        const ProfileEdit(fullName: 'Rauf', username: 'tester', hint: ' '),
      );
      expect((await env.repos.users.current())!.passwordHint, isNull);
    });

    test(
      'keeping your own username is fine, taking another\'s is not',
      () async {
        await env.switchTo('bob');
        await env.useCases.loginUser('tester', 'secret123');
        await env.useCases.updateProfile(
          const ProfileEdit(fullName: 'New Name', username: 'TESTER'),
        );
        expect(
          await failureOf(
            () => env.useCases.updateProfile(
              const ProfileEdit(fullName: 'X Y', username: ' Bob '),
            ),
          ),
          AuthFailure.usernameTaken,
        );
        expect((await env.repos.users.current())!.username, 'tester');
      },
    );

    test('invalid values are rejected', () async {
      for (final bad in [
        const ProfileEdit(fullName: 'R', username: 'tester'),
        const ProfileEdit(fullName: 'Rauf', username: 'a b'),
      ]) {
        expect(
          await failureOf(() => env.useCases.updateProfile(bad)),
          AuthFailure.invalidInput,
        );
      }
    });

    test('changes touch only that user', () async {
      final other = await env.switchTo('bob');
      await env.useCases.updateProfile(
        const ProfileEdit(fullName: 'Bob Changed', username: 'bob'),
      );
      await env.useCases.loginUser('tester', 'secret123');
      expect((await env.repos.users.current())!.fullName, 'User tester');
      expect((await env.repos.users.byId(other))!.fullName, 'Bob Changed');
    });
  });

  group('change password', () {
    test(
      'needs the old password; afterwards only the new one logs in',
      () async {
        expect(
          await failureOf(
            () => env.useCases.changePassword('wrong', 'newsecret1'),
          ),
          AuthFailure.wrongPassword,
        );
        await env.useCases.changePassword('secret123', 'newsecret1');
        await env.useCases.logoutUser();
        expect(
          await failureOf(() => env.useCases.loginUser('tester', 'secret123')),
          AuthFailure.invalidCredentials,
        );
        await env.useCases.loginUser('tester', 'newsecret1');
        expect(env.session.activeId, env.userId);
      },
    );

    test(
      'the new password must be long enough and not given away by the hint',
      () async {
        await env.useCases.updateProfile(
          const ProfileEdit(
            fullName: 'Rauf',
            username: 'tester',
            hint: 'it is fluffy99',
          ),
        );
        expect(
          await failureOf(
            () => env.useCases.changePassword('secret123', '12345'),
          ),
          AuthFailure.invalidInput,
        );
        expect(
          await failureOf(
            () => env.useCases.changePassword('secret123', 'FLUFFY99'),
          ),
          AuthFailure.invalidInput,
        );
        await env.useCases.changePassword('secret123', 'otherpass1');
      },
    );

    test('does not affect other users', () async {
      await env.switchTo('bob');
      await env.useCases.loginUser('tester', 'secret123');
      await env.useCases.changePassword('secret123', 'newsecret1');
      await env.useCases.loginUser('bob', 'secret123');
    });
  });

  group('avatar', () {
    test(
      'a preset is stored; replacing a photo deletes the old file',
      () async {
        final picker = _Picker();
        final setAvatar = SetAvatar(env.repos.users, picker);
        picker.next = Avatar.file('a.jpg');
        expect(await setAvatar.pickPhoto(), isTrue);
        expect((await env.repos.users.current())!.avatarUrl, 'file:a.jpg');
        await setAvatar(Avatar.preset(3));
        expect((await env.repos.users.current())!.avatarUrl, 'preset:3');
        expect(picker.discarded, ['file:a.jpg']);
      },
    );

    test('cancelling the gallery changes nothing', () async {
      final picker = _Picker();
      final setAvatar = SetAvatar(env.repos.users, picker);
      expect(await setAvatar.pickPhoto(), isFalse);
      expect((await env.repos.users.current())!.avatarUrl, isNull);
    });

    test('avatar values are parsed by kind', () {
      expect(Avatar.presetIndex('preset:4'), 4);
      expect(Avatar.presetIndex('file:x.jpg'), isNull);
      expect(Avatar.fileName('file:x.jpg'), 'x.jpg');
      expect(Avatar.fileName(null), isNull);
    });
  });
}
