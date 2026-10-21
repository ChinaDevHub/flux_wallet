import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/home/domain/usecases/load_home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._load) : super(const HomeLoading());

  final LoadHomeSnapshot _load;

  Future<void> load() async {
    try {
      emit(HomeLoaded(await _load()));
    } catch (_) {
      emit(const HomeFailure());
    }
  }
}
