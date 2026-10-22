import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/notices/domain/entities/notice.dart';
import 'package:flux_wallet/features/notices/presentation/cubit/notices_cubit.dart';

/// A [NoticesCubit] with a fixed list, for widgets that only show the bell.
class FakeNoticesCubit extends Cubit<List<Notice>> implements NoticesCubit {
  FakeNoticesCubit([super.notices = const []]);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
