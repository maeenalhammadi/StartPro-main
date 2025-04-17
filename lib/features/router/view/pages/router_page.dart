import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/features/auth/view/pages/login_page.dart';
import 'package:start_pro/features/home/view/pages/home_page.dart';

class RouterPage extends ConsumerWidget {
  const RouterPage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const LoginPage();
    }
    return const HomePage();
  }
}
