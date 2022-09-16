part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class CheckRememberMe extends AuthEvent {
  final bool rememberMe;

  const CheckRememberMe({this.rememberMe = false});

  @override
  List<Object?> get props => [rememberMe];
}

class DoLogin extends AuthEvent {
  final String username, password;
  final bool rememberMe;

  const DoLogin({
    this.username = '',
    this.password = '',
    this.rememberMe = false,
  });

  @override
  List<Object?> get props => [username, password, rememberMe];
}
