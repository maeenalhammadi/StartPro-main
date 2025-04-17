import 'package:flutter/material.dart';
import 'package:start_pro/core/constants/hero_tags.dart';
import 'package:start_pro/core/widgets/logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Hero(tag: HeroTags.logo, child: Logo(size: 190))),
    );
  }
}
