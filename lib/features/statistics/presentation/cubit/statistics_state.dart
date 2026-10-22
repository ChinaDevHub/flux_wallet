import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';

sealed class StatisticsState extends Equatable {
  const StatisticsState();

  @override
  List<Object?> get props => const [];
}

class StatisticsLoading extends StatisticsState {
  const StatisticsLoading();
}

class StatisticsFailure extends StatisticsState {
  const StatisticsFailure();
}

class StatisticsLoaded extends StatisticsState {
  const StatisticsLoaded(this.view);

  final StatisticsView view;

  @override
  List<Object?> get props => [view];
}
