import 'package:flutter_bloc/flutter_bloc.dart';

/// Which main tab is open, so other screens can send the user to one.
class ShellTabCubit extends Cubit<int> {
  ShellTabCubit() : super(0);

  void select(int index) => emit(index);
}
