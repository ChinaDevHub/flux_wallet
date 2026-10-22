import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/notifications/domain/entities/raw_notification.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/confirm_pending.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/ingest_notification.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/load_pending_views.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_draft.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_item.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_state.dart';

class ApprovalCubit extends ReloadingCubit<ApprovalState> {
  ApprovalCubit(this._load, this._confirm, this._ingest, Stream<void> changes)
    : super(const ApprovalLoading(), changes);

  final LoadPendingViews _load;
  final ConfirmPending _confirm;
  final IngestNotification _ingest;
  final _drafts = <int, ApprovalDraft>{};

  @override
  Future<void> load() async {
    try {
      final views = await _load();
      emit(
        ApprovalLoaded([
          for (final v in views) ApprovalItem.from(v, _drafts[v.pending.id]),
        ]),
      );
    } catch (_) {
      emit(const ApprovalFailure());
    }
  }

  void _edit(int id, ApprovalDraft Function(ApprovalDraft) change) {
    _drafts[id] = change(_drafts[id] ?? const ApprovalDraft());
    load();
  }

  void setCategory(int id, String c) =>
      _edit(id, (d) => d.copyWith(category: c));
  void setReplaceBus(int id, bool v) =>
      _edit(id, (d) => d.copyWith(replaceBus: v));
  void setRemember(int id, bool v) => _edit(id, (d) => d.copyWith(remember: v));

  Future<void> confirm(ApprovalItem item) => item.confirmUsing(_confirm);

  Future<void> dismiss(ApprovalItem item) => _confirm.dismiss(item.view);

  Future<bool> addText(String text) =>
      _ingest(RawNotification(text: text, receivedAt: DateTime.now()));
}
