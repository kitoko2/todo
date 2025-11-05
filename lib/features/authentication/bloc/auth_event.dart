import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/app_user.dart';

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
  final AppUser user;
  
  const RegisterEvent({required this.user});
  @override
  List<Object> get props => [user];
}

class LogoutEvent extends AuthEvent {}
