part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class Loading extends LoginState {}

class Error extends LoginState {
  final String error;
  Error({required this.error});
}

class AuthSuccess extends LoginState {
  final AllLoginModel empDetails;
  AuthSuccess({required this.empDetails});
}
