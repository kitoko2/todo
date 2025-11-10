import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/auth_repository.dart';
import 'package:todo/domain/entities/register_form_data.dart';
import 'package:todo/features/authentication/bloc/auth_event.dart';
import 'package:todo/features/authentication/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthState()) {
    on<LoginEvent>(loginUser);
    on<RegisterEvent>(registerUser);
    on<LogoutEvent>(logoutUser);
  }

  // Ajoutez des logs pour débugger
  void loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await authRepository.signInWithEmailPassword(
        event.email,
        event.password,
      );

      result.fold(
        (failure) => emit(state.copyWith(errorMessage: failure.message)),
        (user) => emit(state.copyWith(user: user)),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void registerUser(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final result = await authRepository.register(
        RegisterFormData(
          email: event.email,
          password: event.password,
          name: event.username,
        ),
      );

      result.fold(
        (failure) => emit(state.copyWith(errorMessage: failure.message)),
        (user) => emit(state.copyWith(user: user)),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void logoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {} catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
