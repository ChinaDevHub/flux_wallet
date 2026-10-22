import 'package:flux_wallet/core/bloc/reloading_cubit.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/domain/usecases/load_notices.dart';

/// The notices for the bell and its page; reloads whenever data changes.
class NoticesCubit extends ReloadingCubit<List<Notice>> {
  NoticesCubit(this._load, Stream<void> changes) : super(const [], changes);

  final LoadNotices _load;

  @override
  Future<void> load() async => emit(await _load());
}
