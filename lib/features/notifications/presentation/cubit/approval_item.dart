import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/notifications/domain/entities/pending_view.dart';
import 'package:flux_wallet/features/notifications/domain/usecases/confirm_pending.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_draft.dart';

class ApprovalItem extends Equatable {
  const ApprovalItem({
    required this.view,
    required this.category,
    required this.replaceBus,
    required this.remember,
  });

  factory ApprovalItem.from(PendingView view, ApprovalDraft? draft) {
    final d = draft ?? const ApprovalDraft();
    return ApprovalItem(
      view: view,
      category: d.category ?? view.pending.category,
      replaceBus: d.replaceBus,
      remember: d.remember,
    );
  }

  final PendingView view;
  final String? category;
  final bool? replaceBus;
  final bool remember;

  int get id => view.pending.id!;

  /// Only a taxi can take a bus fare's place.
  bool get asksAboutBus => category == 'taxi' && view.replaceableBus != null;

  bool get canConfirm =>
      category != null && (!asksAboutBus || replaceBus != null);

  /// Books it with the choices made on the card.
  Future<void> confirmUsing(ConfirmPending confirm) => confirm(
    view,
    category: category!,
    replaceBus: replaceBus ?? false,
    remember: remember,
  );

  @override
  List<Object?> get props => [view, category, replaceBus, remember];
}
