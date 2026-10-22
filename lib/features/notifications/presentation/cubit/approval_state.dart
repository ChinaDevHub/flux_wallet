import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/notifications/presentation/cubit/approval_item.dart';

sealed class ApprovalState extends Equatable {
  const ApprovalState();

  @override
  List<Object?> get props => const [];
}

class ApprovalLoading extends ApprovalState {
  const ApprovalLoading();
}

class ApprovalFailure extends ApprovalState {
  const ApprovalFailure();
}

class ApprovalLoaded extends ApprovalState {
  const ApprovalLoaded(this.items);

  final List<ApprovalItem> items;

  @override
  List<Object?> get props => [items];
}
