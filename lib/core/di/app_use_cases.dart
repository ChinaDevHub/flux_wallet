import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/use_cases/use_case_bundle.dart';
import 'package:flux_wallet/core/session/session_store.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/auth/data/pbkdf2_password_hasher.dart';
import 'package:flux_wallet/features/auth/domain/repositories/password_hasher.dart';
import 'package:flux_wallet/features/profile/data/gallery_avatar_picker.dart';
import 'package:flux_wallet/features/profile/domain/repositories/avatar_picker.dart';
import 'package:flux_wallet/features/settings/data/file_backup_gateway.dart';
import 'package:flux_wallet/features/settings/data/local_reminder_scheduler.dart';
import 'package:flux_wallet/features/settings/domain/repositories/backup_gateway.dart';
import 'package:flux_wallet/features/settings/domain/repositories/reminder_scheduler.dart';

/// Use cases wired to the data layer, grouped by area in `use_cases/`.
class AppUseCases extends UseCaseBundle {
  AppUseCases(
    this.repos,
    this.session,
    this.clock, {
    this.hasher = const Pbkdf2PasswordHasher(),
    this.avatarPicker = const GalleryAvatarPicker(),
    this.gateway = const FileBackupGateway(),
    ReminderScheduler? reminders,
  }) : reminders = reminders ?? LocalReminderScheduler();

  @override
  final AppRepositories repos;
  @override
  final SessionStore session;
  @override
  final PasswordHasher hasher;
  @override
  final AvatarPicker avatarPicker;
  @override
  final Clock clock;
  @override
  final BackupGateway gateway;
  @override
  final ReminderScheduler reminders;
}
