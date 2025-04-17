import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/core/enum/toast_type.dart';
import 'package:start_pro/core/utils/show_toast.dart';
import 'package:start_pro/features/auth/repository/login_repository.dart';
import 'package:start_pro/features/home/view/pages/home_page.dart';

class LoginState {
  final bool isLoading;
  final String? error;

  const LoginState({this.isLoading = false, this.error});

  LoginState copyWith({bool? isLoading, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier({required LoginRepository repository})
    : _repository = repository,
      super(const LoginState());

  final LoginRepository _repository;

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.login(email: email, password: password);

    result.fold(
      (failure) {
        toast(
          context,
          Locales.string(context, failure.message),
          type: ToastType.error,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (userCredential) {
        toast(
          context,
          Locales.string(context, 'login_success'),
          subtitle: Locales.string(context, 'welcome_back'),
          type: ToastType.success,
        );
        state = state.copyWith(isLoading: false);
        Navigator.pushReplacementNamed(context, HomePage.route);
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.logout();

    result.fold(
      (failure) {
        toast(
          context,
          Locales.string(context, failure.message),
          type: ToastType.error,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (_) {
        toast(
          context,
          Locales.string(context, 'logout_success'),
          type: ToastType.success,
        );
        state = state.copyWith(isLoading: false);
      },
    );
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.resetPassword(email);

    result.fold(
      (failure) {
        toast(
          context,
          Locales.string(context, failure.message),
          type: ToastType.error,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (_) {
        toast(
          context,
          Locales.string(context, 'reset_password_success'),
          subtitle: Locales.string(context, 'check_email_for_reset'),
          type: ToastType.success,
        );
        state = state.copyWith(isLoading: false);
      },
    );
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
      final repository = ref.watch(loginRepositoryProvider);
      return LoginNotifier(repository: repository);
    });
