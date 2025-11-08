import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/features/authentication/bloc/auth_event.dart';
import 'package:todo/features/authentication/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(loginUser);
    on<RegisterEvent>(registerUser);
    on<LogoutEvent>(logoutUser);
  }

  // Ajoutez des logs pour débugger
  void loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    print('Tentative de connexion avec: ${event.email}');

    emit(state.copyWith(isLoading: true));

    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: event.email.trim(), // Supprime les espaces
            password: event.password,
          );

      print('✅ Connexion réussie: ${userCredential.user?.uid}');
      emit(state.copyWith(isLoading: false, isAuthenticated: true));
    } on FirebaseAuthException catch (e) {
      print('❌ Erreur Firebase: ${e.code} - ${e.message}');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Email ou mot de passe incorrect',
        ),
      );
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
