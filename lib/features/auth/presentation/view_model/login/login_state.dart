part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseEntity loginResponseEntity;
  LoginSuccess(this.loginResponseEntity);
}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
}
