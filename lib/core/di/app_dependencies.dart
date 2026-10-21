import 'package:flux_wallet/core/database/app_database.dart';
import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/di/app_use_cases.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/onboarding/domain/repositories/profile_repository.dart';

/// Composition root: the only place that knows the concrete implementations.
class AppDependencies {
  AppDependencies({AppDatabase? database, this.clock = DateTime.now})
    : database = database ?? AppDatabase() {
    repos = AppRepositories(this.database);
    useCases = AppUseCases(repos, clock);
  }

  final AppDatabase database;
  final Clock clock;
  late final AppRepositories repos;
  late final AppUseCases useCases;

  /// Fires after every database write; cubits reload from it.
  Stream<void> get changes => database.changes;

  ProfileRepository get profile => repos.profile;
}
