import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:start_pro/core/constants/hero_tags.dart';
import 'package:start_pro/core/widgets/logo.dart';
import 'package:start_pro/features/auth/view/widgets/login_form.dart';
import 'package:start_pro/features/auth/view/widgets/login_message.dart';
import 'package:start_pro/features/auth/view/widgets/login_welcome.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(60.h),
                Hero(
                  tag: HeroTags.logo,
                  child: const Logo(size: 140),
                ),
                Gap(60.h),
                const LoginWelcome(),
                Gap(40.h),
                const LoginForm(),
                Gap(1.h),
                const LoginMessage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
