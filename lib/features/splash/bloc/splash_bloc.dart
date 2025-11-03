import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/data/auth_repository.dart';

// Events
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class CheckAppStatusEvent extends SplashEvent {}

// States
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashAuthenticated extends SplashState {}

class SplashUnauthenticated extends SplashState {}

class SplashOnboardingCompleted extends SplashState {}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);

  @override
  List<Object?> get props => [message];
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final AuthRepository authRepository;

  SplashBloc({required this.authRepository}) : super(SplashInitial()) {
    on<CheckAppStatusEvent>(_onCheckAppStatus);
  }

  /// Vérifie le statut complet de l'application (authentification et onboarding)
  Future<void> _onCheckAppStatus(
    CheckAppStatusEvent event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading());

    try {
      // Vérifier d'abord le statut d'authentification
      final isAuthenticated = await _isUserAuthenticated();

      if (isAuthenticated) {
        emit(SplashAuthenticated());
        return;
      }

      // Si non authentifié, vérifier le statut d'onboarding
      final isOnboardingCompleted = await _isOnboardingCompleted();

      if (isOnboardingCompleted) {
        // Si l'onboarding a déjà été terminé, aller directement à la page de connexion
        emit(SplashOnboardingCompleted());
      } else {
        // Si l'onboarding n'a pas été terminé, montrer l'onboarding
        emit(SplashUnauthenticated());
      }
    } catch (e) {
      emit(SplashError("Une erreur inattendue s'est produite"));
    }
  }

  /// Méthode d'aide pour vérifier si l'utilisateur est authentifié
  Future<bool> _isUserAuthenticated() async {
    return await authRepository.isAuthenticated();
  }

  /// Méthode d'aide pour vérifier si l'onboarding a été complété
  Future<bool> _isOnboardingCompleted() async {
    return false;
    // final onboardingResult = await checkOnboardingStatus.execute();

    // return onboardingResult.fold(
    //   (failure) =>
    //       false, // En cas d'erreur, considérer que l'onboarding n'est pas complété
    //   (isCompleted) => isCompleted,
    // );
  }
}
