import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';

sealed class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object?> get props => const [];
}

class TimelineLoading extends TimelineState {
  const TimelineLoading();
}

class TimelineFailure extends TimelineState {
  const TimelineFailure();
}

class TimelineLoaded extends TimelineState {
  const TimelineLoaded(this.view, this.monthOffset);

  final TimelineView view;

  /// 0 = current month, 1 = next month.
  final int monthOffset;

  @override
  List<Object?> get props => [view, monthOffset];
}
