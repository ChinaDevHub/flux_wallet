import 'package:flux_wallet/core/di/use_cases/schedule_use_cases.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/confirm_pending.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/ingest_notification.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/load_pending_views.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/suggest_category.dart';

/// Bank messages: parse, queue, confirm.
mixin NotificationUseCases on ScheduleUseCases {
  late final suggestCategory = SuggestCategory(repos.merchants);
  late final ingest = IngestNotification(repos.pending, suggestCategory);
  late final loadPending = LoadPendingViews(
    repos.pending,
    repos.rules,
    loadSchedule,
  );
  late final confirmPending = ConfirmPending(
    repos.pending,
    repos.transactions,
    repos.merchants,
    repos.accounts,
    scheduleEditor,
  );
}
