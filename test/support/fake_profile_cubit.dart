import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flux_wallet/features/profile/presentation/cubit/profile_state.dart';

/// A signed-out [ProfileCubit] for widgets that only show the avatar button.
class FakeProfileCubit extends Cubit<ProfileState> implements ProfileCubit {
  FakeProfileCubit() : super(const ProfileState());

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
