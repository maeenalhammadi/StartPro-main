import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = Provider<User>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    throw Exception('User not found');
  }
  return user;
});
