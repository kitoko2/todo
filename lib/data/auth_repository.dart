import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/errors/failures.dart';
import 'package:todo/domain/entities/app_user.dart';
import 'package:todo/domain/entities/register_form_data.dart';

import '../utils/constants/firebase_collection.dart';

abstract class AuthRepository {
  Future<bool> isAuthenticated();
  Future<Either<Failure, AppUser>> signInWithEmailPassword(
    String email,
    String password,
  );
  Future<Either<Failure, AppUser>> register(RegisterFormData formData);
  Future<Either<Failure, void>> signOut();
  Stream<AppUser?> get authStateChanges;
  AppUser? getCurrentUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthRepositoryImpl({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<bool> isAuthenticated() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      return false;
    }
  }

  @override
  AppUser? getCurrentUser() {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;

    return AppUser(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName ?? '',
      phoneNumber: firebaseUser.phoneNumber,
      photoUrl: firebaseUser.photoURL,
      emailVerified: firebaseUser.emailVerified,
    );
  }

  @override
  Stream<AppUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;

      return AppUser(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL,
        emailVerified: firebaseUser.emailVerified,
      );
    });
  }

  @override
  Future<Either<Failure, AppUser>> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return Left(ServerFailure(message: 'Échec de connexion'));
      }

      final user = AppUser(
        id: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
        phoneNumber: firebaseUser.phoneNumber,
        photoUrl: firebaseUser.photoURL,
        emailVerified: firebaseUser.emailVerified,
      );

      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(handleAuthException(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUser>> register(RegisterFormData formData) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: formData.email,
        password: formData.password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        return Left(ServerFailure(message: 'Échec de création du compte'));
      }

      await firebaseUser.updateDisplayName(formData.name);
      await firebaseUser.reload();
      final updatedUser = _firebaseAuth.currentUser;

      final user = AppUser(
        id: updatedUser!.uid,
        email: updatedUser.email ?? '',
        name: updatedUser.displayName ?? formData.name,
        phoneNumber: formData.phoneNumber,
        emailVerified: updatedUser.emailVerified,
      );
      _firebaseFirestore
          .collection(FirebaseCollections.usersCollection)
          .doc(user.id)
          .set(user.toJson());

      return Right(user);
    } on FirebaseAuthException catch (e, s) {
      print(s);
      return Left(handleAuthException(e));
    } catch (e, s) {
      print(s);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
