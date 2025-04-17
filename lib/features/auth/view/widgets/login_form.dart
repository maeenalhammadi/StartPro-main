import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/constants/regex.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/core/types/future_void.dart';
import 'package:start_pro/core/widgets/loading_button.dart';
import 'package:gap/gap.dart';
import 'package:start_pro/features/auth/controller/login_controller.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);

    FutureVoid handleSubmit() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      await ref
          .read(loginControllerProvider.notifier)
          .login(
            context,
            email: _emailController.text,
            password: _passwordController.text,
          );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: Locales.string(context, 'email'),
                hintText: Locales.string(context, 'email_hint'),
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.kPrimaryColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Locales.string(context, 'email_required');
                }
                if (!Regex.email.hasMatch(value)) {
                  return Locales.string(context, 'email_invalid');
                }
                return null;
              },
            ),
            Gap(16.h),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: Locales.string(context, 'password'),
                hintText: Locales.string(context, 'password_hint'),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.kPrimaryColor),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Locales.string(context, 'password_required');
                }
                if (value.length < 6) {
                  return Locales.string(context, 'password_invalid');
                }
                return null;
              },
            ),
            Gap(24.h),
            LoadingButton(
              text: Locales.string(context, 'login'),
              onPressed: handleSubmit,
              isLoading: loginState.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
