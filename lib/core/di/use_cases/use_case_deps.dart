import 'package:flux_wallet/core/di/app_repositories.dart';
import 'package:flux_wallet/core/session/session_store.dart';
import 'package:flux_wallet/core/utils/date_utils.dart';

/// What every use-case group needs; `AppUseCases` provides it.
abstract class UseCaseDeps {
  AppRepositories get repos;
  SessionStore get session;
  Clock get clock;
}
