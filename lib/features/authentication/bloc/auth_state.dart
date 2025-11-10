import 'package:equatable/equatable.dart';
import 'package:todo/domain/entities/app_user.dart';

class AuthState extends Equatable {
  final AppUser? user;
  final bool? isLoading;
  final bool? isAuthenticated;
  final String? errorMessage;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage,
  });

  AuthState copyWith({
    AppUser? user,
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, isAuthenticated, errorMessage];
}
