import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/constants/regex.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/core/types/future_void.dart';
import 'package:start_pro/core/widgets/loading_button.dart';
import 'package:gap/gap.dart';
import 'package:start_pro/features/auth/controller/register_controller.dart';
import 'package:start_pro/features/auth/models/new_user.dart';

class RegisterForm extends ConsumerStatefulWidget {
  const RegisterForm({super.key});
  @override
  ConsumerState<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerControllerProvider);

    FutureVoid handleSubmit() async {
      if (!_formKey.currentState!.validate() || !_acceptedTerms) {
        return;
      }

      final user = NewUserModel(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        createdAt: DateTime.now(),
      );

      await ref
          .read(registerControllerProvider.notifier)
          .register(context, user);
      return null;
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: Locales.string(context, 'first_name'),
                      hintText: Locales.string(context, 'first_name_hint'),
                      prefixIcon: const Icon(Icons.person_outline),
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
                        return Locales.string(context, 'first_name_required');
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: Locales.string(context, 'last_name'),
                      hintText: Locales.string(context, 'last_name_hint'),
                      prefixIcon: const Icon(Icons.person_outline),
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
                        return Locales.string(context, 'last_name_required');
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Gap(16.h),

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
            Gap(16.h),

            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              decoration: InputDecoration(
                labelText: Locales.string(context, 'confirm_password'),
                hintText: Locales.string(context, 'confirm_password_hint'),
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
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
                  return Locales.string(context, 'confirm_password_required');
                }
                if (value != _passwordController.text) {
                  return Locales.string(context, 'passwords_do_not_match');
                }
                return null;
              },
            ),
            Gap(16.h),

            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value ?? false;
                    });
                  },
                  activeColor: AppColors.kPrimaryColor,
                ),
                Expanded(
                  child: Text(
                    Locales.string(context, 'terms_and_conditions_agreement'),
                    style: TextStyle(
                      color: AppColors.kTextSecondaryColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            Gap(24.h),
            LoadingButton(
              onPressed: handleSubmit,
              text: Locales.string(context, 'register'),
              isLoading: registerState.isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
