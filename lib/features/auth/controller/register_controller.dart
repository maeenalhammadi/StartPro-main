import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:start_pro/core/enum/toast_type.dart';
import 'package:start_pro/core/utils/show_toast.dart';
import 'package:start_pro/features/auth/models/new_user.dart';
import 'package:start_pro/features/auth/repository/register_repository.dart';

// State class to handle loading state
class RegisterState {
  final bool isLoading;
  final String? error;

  const RegisterState({this.isLoading = false, this.error});

  RegisterState copyWith({bool? isLoading, String? error}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// StateNotifier class
class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier({required RegisterRepository repository})
    : _repository = repository,
      super(const RegisterState());

  final RegisterRepository _repository;

  Future<void> register(BuildContext context, NewUserModel user) async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.register(user);

    result.fold(
      (failure) {
        toast(
          context,
          Locales.string(context, failure.message),
          type: ToastType.error,
        );
        state = state.copyWith(isLoading: false, error: failure.message);
      },
      (success) {
        toast(
          context,
          Locales.string(context, 'register_success'),
          subtitle: Locales.string(context, 'register_success_subtitle'),
          type: ToastType.success,
        );
        state = state.copyWith(isLoading: false);
        Navigator.pop(context);
      },
    );
  }
}

// Provider
final registerControllerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
      final repository = ref.watch(registerRepositoryProvider);
      return RegisterNotifier(repository: repository);
    });
