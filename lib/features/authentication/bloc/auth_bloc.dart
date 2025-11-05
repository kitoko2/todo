import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/authentication/bloc/auth_event.dart';
import 'package:todo/features/authentication/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(loginUser);
    on<RegisterEvent>(registerUser);
    on<LogoutEvent>(logoutUser);
  }

  void loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(errorMessage: "Bad credentials"));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false, errorMessage: null));
    }
  }

  void registerUser(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {} catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void logoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {} catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
