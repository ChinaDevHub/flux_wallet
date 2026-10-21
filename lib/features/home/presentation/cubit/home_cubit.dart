import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/home/domain/usecases/load_home_snapshot.dart';
import 'package:flux_wallet/features/home/presentation/cubit/home_state.dart';

class HomeCubit extends ReloadingCubit<HomeState> {
  HomeCubit(this._load, Stream<void> changes)
    : super(const HomeLoading(), changes);

  final LoadHomeSnapshot _load;

  @override
  Future<void> load() async {
    try {
      emit(HomeLoaded(await _load()));
    } catch (_) {
      emit(const HomeFailure());
    }
  }
}
