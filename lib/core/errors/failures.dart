// Gestion des erreurs Firebase Auth
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Abstract class representing a Failure in the application
abstract class Failure extends Equatable {
  /// Message describing the failure
  final String message;

  /// Constructor for Failure
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

/// Represents a server-related failure
class ServerFailure extends Failure {
  /// Constructor for ServerFailure
  const ServerFailure({required super.message});
}

Failure handleAuthException(FirebaseAuthException e) {
  switch (e.code) {
    case 'user-not-found':
      return ServerFailure(message: 'Aucun utilisateur trouvé avec cet email');
    case 'wrong-password':
      return ServerFailure(message: 'Mot de passe incorrect');
    case 'email-already-in-use':
      return ServerFailure(message: 'Cet email est déjà utilisé');
    case 'invalid-email':
      return ServerFailure(message: 'Email invalide');
    case 'weak-password':
      return ServerFailure(message: 'Le mot de passe est trop faible');
    case 'user-disabled':
      return ServerFailure(message: 'Ce compte a été désactivé');
    case 'too-many-requests':
      return ServerFailure(message: 'Trop de tentatives. Réessayez plus tard');
    case 'operation-not-allowed':
      return ServerFailure(message: 'Opération non autorisée');
    case 'invalid-verification-code':
      return ServerFailure(message: 'Code de vérification invalide');
    case 'invalid-verification-id':
      return ServerFailure(message: 'ID de vérification invalide');
    default:
      return ServerFailure(message: e.message ?? 'Erreur inconnue');
  }
}
