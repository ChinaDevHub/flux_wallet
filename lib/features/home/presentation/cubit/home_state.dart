import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/home/domain/entities/home_snapshot.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => const [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeFailure extends HomeState {
  const HomeFailure();
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.snapshot);

  final HomeSnapshot snapshot;

  @override
  List<Object?> get props => [snapshot];
}
