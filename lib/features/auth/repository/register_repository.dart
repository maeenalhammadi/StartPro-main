import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:start_pro/core/constants/collections.dart';
import 'package:start_pro/core/types/types.dart';
import 'package:start_pro/core/providers/providers.dart';
import 'package:start_pro/features/auth/models/new_user.dart';

final registerRepositoryProvider = Provider<RegisterRepository>(
  (ref) => RegisterRepository(
    auth: ref.watch(firebaseAuthProvider),
    database: ref.watch(firestoreProvider),
  ),
);

abstract class IRegisterRepository {
  FutureEither<void> register(NewUserModel user);
}

class RegisterRepository implements IRegisterRepository {
  RegisterRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore database,
  }) : _auth = auth,
       _database = database;

  final FirebaseAuth _auth;
  final FirebaseFirestore _database;

  @override
  FutureEither<void> register(NewUserModel user) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      await _auth.currentUser?.updateDisplayName(
          '${user.firstName} ${user.lastName}');

      final token = await _auth.currentUser?.getIdTokenResult();
      print('token: $token');

      if (token == null) {
        return Left(Failure('could_not_register', 'User is null'));
      }

      if (token.claims?['role'] == 'USER') {
        await _auth.currentUser?.getIdTokenResult();
      }

      if (response.user == null) {
        return Left(Failure('could_not_register', 'User is null'));
      }

      await _database
          .collection(Collections.users)
          .doc(response.user!.uid)
          .set(user.toMap());

      return Right(null);
    } catch (e) {
      return Left(Failure('could_not_register', e.toString()));
    }
  }
}
