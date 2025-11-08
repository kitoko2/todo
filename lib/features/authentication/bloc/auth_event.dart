import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// action liée à l'evenement Auth
// login action
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

// register action
class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  const RegisterEvent({
    required this.email,
    required this.password,
    required this.username,
  });
  @override
  List<Object> get props => [username, email, password];
}

class LogoutEvent extends AuthEvent {}
