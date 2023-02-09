part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonClick extends LoginEvent {
  final String id, password;
  LoginButtonClick({required this.id, required this.password});
}
