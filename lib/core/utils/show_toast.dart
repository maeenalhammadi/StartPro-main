import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/core/enum/toast_type.dart';

void toast(
  BuildContext context,
  String message, {
  ToastType type = ToastType.info,
  String? subtitle,
}) {
  final config = switch (type) {
    ToastType.success => (
      color: AppColors.kSuccessColor,
      icon: Icons.check_circle_outline,
    ),
    ToastType.error => (
      color: AppColors.kErrorColor,
      icon: Icons.error_outline,
    ),
    ToastType.warning => (
      color: AppColors.kWarningColor,
      icon: Icons.warning_amber_outlined,
    ),
    ToastType.info => (
      color: AppColors.kPrimaryColor,
      icon: Icons.info_outline,
    ),
  };

  DelightToastBar(
    position: DelightSnackbarPosition.top,
    autoDismiss: true,
    builder:
        (context) => ToastCard(
          leading: Icon(config.icon, size: 28),
          color: config.color,
          title: Text(
            message,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          subtitle:
              subtitle != null
                  ? Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.kTextSecondaryColor,
                    ),
                  )
                  : null,
        ),
  ).show(context);
}
