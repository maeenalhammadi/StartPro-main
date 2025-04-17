import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_pro/features/auth/view/pages/login_page.dart';

void logout(BuildContext context) {
  FirebaseAuth.instance.signOut();
  Navigator.pushNamedAndRemoveUntil(
    context,
    LoginPage.route,
    (route) => false,
  );
}
