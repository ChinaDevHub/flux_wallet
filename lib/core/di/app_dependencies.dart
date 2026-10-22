import 'package:flutter/foundation.dart';
import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/core/session/session_store.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/notifications/data/android_notification_source.dart';
import 'package:flux_wallet/features/notifications/data/no_notification_source.dart';
import 'package:flux_wallet/features/notifications/domain/repositories/notification_source.dart';

/// Composition root: the only place that knows the concrete implementations.
class AppDependencies {
  AppDependencies({AppDatabase? database, this.clock = DateTime.now})
    : database = database ?? AppDatabase() {
    session = SessionStore(this.database);
    repos = AppRepositories(this.database, session);
    useCases = AppUseCases(repos, session, clock);
  }

  /// Android reads bank notifications natively; iOS has no such access.
  late final NotificationSource notificationSource =
      defaultTargetPlatform == TargetPlatform.android
      ? AndroidNotificationSource()
      : const NoNotificationSource();

  final AppDatabase database;
  final Clock clock;
  late final SessionStore session;
  late final AppRepositories repos;
  late final AppUseCases useCases;

  /// Fires after every database write; cubits reload from it.
  Stream<void> get changes => database.changes;
}
