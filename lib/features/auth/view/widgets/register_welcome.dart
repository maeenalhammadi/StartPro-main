import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterWelcome extends StatelessWidget {
  const RegisterWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: Locales.string(context, 'oh_hey'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextSpan(
                text: ' ',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              // make the text bold
              TextSpan(
                text: Locales.string(context, 'startpro'),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Gap(2.h),
        Text(
          Locales.string(context, 'register_message'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
