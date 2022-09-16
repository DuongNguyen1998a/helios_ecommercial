part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  final bool rememberMe;
  final String username;
  final String password;

  const AuthInitial({
    this.rememberMe = false,
    this.username = '',
    this.password = '',
  });

  @override
  List<Object> get props => [rememberMe, username, password];
}

class AuthLoading extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {

  @override
  List<Object> get props => [];
}

class AuthFailed extends AuthState {

  @override
  List<Object> get props => [];
}
