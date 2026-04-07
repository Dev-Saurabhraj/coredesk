import 'package:equatable/equatable.dart';
import 'package:coredesk/features/authentication/data/models/auth_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthSuccess extends AuthState {
  final AuthModel auth;

  const AuthSuccess(this.auth);

  @override
  List<Object?> get props => [auth];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {
  const AuthLoggedOut();
}
