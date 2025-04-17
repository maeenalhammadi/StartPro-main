import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:start_pro/core/constants/hero_tags.dart';
import 'package:start_pro/core/widgets/logo.dart';
import 'package:start_pro/features/auth/view/widgets/login_form.dart';
import 'package:start_pro/features/auth/view/widgets/login_welcome.dart';
import 'package:start_pro/features/auth/view/widgets/register_form.dart';
import 'package:start_pro/features/auth/view/widgets/register_message.dart';
import 'package:start_pro/features/auth/view/widgets/register_welcome.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static const route = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, 'new account')),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(5.h),
                Hero(tag: HeroTags.logo, child: const Logo()),
                Gap(5.h),
                const RegisterForm(),
                Gap(1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
