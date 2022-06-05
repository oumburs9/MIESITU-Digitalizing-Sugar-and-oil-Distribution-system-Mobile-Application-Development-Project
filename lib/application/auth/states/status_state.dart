import 'package:equatable/equatable.dart';
import 'package:miesitu/domain/auth/entity/auth_model.dart';

abstract class CurrentStatusState extends Equatable {}

class AppInitState extends CurrentStatusState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends CurrentStatusState {
  final User user;
  AuthenticatedState(this.user);

  @override
  List<Object> get props => [user];
}

class UnAuthenticatedState extends CurrentStatusState {
  @override
  List<Object?> get props => [];
}
