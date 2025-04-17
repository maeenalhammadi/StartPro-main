import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class LoginWelcome extends StatelessWidget {
  const LoginWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: Locales.string(context, 'welcome_to'),
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
        Text(
          Locales.string(context, 'login_message'),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
