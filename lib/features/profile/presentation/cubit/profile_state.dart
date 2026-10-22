import 'package:equatable/equatable.dart';
import 'package:flux_wallet/features/auth/domain/entities/user.dart';

class ProfileState extends Equatable {
  const ProfileState([this.user]);

  /// Null until loaded.
  final User? user;

  @override
  List<Object?> get props => [user];
}
