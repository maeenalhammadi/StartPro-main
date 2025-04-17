import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:start_pro/core/constants/collections.dart';
import 'package:start_pro/core/types/types.dart';
import 'package:start_pro/core/providers/providers.dart';

// Provider
final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(
    auth: ref.watch(firebaseAuthProvider),
    database: ref.watch(firestoreProvider),
  ),
);

// Interface
abstract class ILoginRepository {
  FutureEither<UserCredential> login({
    required String email,
    required String password,
  });
}

// Implementation
class LoginRepository implements ILoginRepository {
  LoginRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore database,
  }) : _auth = auth,
       _database = database;

  final FirebaseAuth _auth;
  final FirebaseFirestore _database;

  @override
  FutureEither<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        return Left(Failure('could_not_login', 'User is null'));
      }

      // Optional: Check if user exists in database
      final userDoc =
          await _database
              .collection(Collections.users)
              .doc(response.user!.uid)
              .get();

      if (!userDoc.exists) {
        await _auth.signOut();
        return Left(
          Failure('user_not_found', 'User does not exist in database'),
        );
      }

      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(
        Failure('could_not_login', switch (e.code) {
          'user-not-found' => 'email_not_found',
          'wrong-password' => 'incorrect_password',
          'user-disabled' => 'account_disabled',
          'invalid-email' => 'invalid_email',
          _ => 'unknown_error',
        }),
      );
    } catch (e) {
      return Left(Failure('could_not_login', e.toString()));
    }
  }

  // Optional: Add logout method
  FutureEither<void> logout() async {
    try {
      await _auth.signOut();
      return Right(null);
    } catch (e) {
      return Left(Failure('could_not_logout', e.toString()));
    }
  }

  // Optional: Add password reset method
  FutureEither<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Right(null);
    } catch (e) {
      return Left(Failure('could_not_reset_password', e.toString()));
    }
  }
}
