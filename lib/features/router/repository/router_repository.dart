import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:start_pro/core/providers/providers.dart';
import 'package:start_pro/core/types/failure.dart';
import 'package:start_pro/core/types/future_either.dart';

final routerRepositoryProvider = Provider<RouterRepository>((ref) {
  return RouterRepository(
    auth: ref.watch(firebaseAuthProvider),
    database: ref.watch(firestoreProvider),
  );
});

abstract class IRouterRepository {
  FutureEither<User> getUser();
}

class RouterRepository extends IRouterRepository {
  RouterRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore database,
  }) : _auth = auth,
       _database = database;

  final FirebaseAuth _auth;
  final FirebaseFirestore _database;

  @override
  FutureEither<User> getUser() async {
    try {
      // Wait for the auth state to be ready
      await Future.delayed(Duration.zero);

      final user = _auth.currentUser;

      if (user == null) {
        return Left(Failure('User not found', StackTrace.current.toString()));
      }

      // Verify user exists in Firestore
      final userDoc = await _database.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        await _auth.signOut();
        return Left(Failure('User not found', StackTrace.current.toString()));
      }

      return Right(user);
    } catch (e) {
      return Left(Failure(e.toString(), StackTrace.current.toString()));
    }
  }

  // Stream to listen to auth state changes
  Stream<User?> authStateChanges() => _auth.authStateChanges();
}
