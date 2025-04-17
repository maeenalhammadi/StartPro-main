import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/features/home/utils/logout.dart';
import 'package:start_pro/features/home/utils/swap_language.dart';
import 'package:start_pro/features/home/view/pages/edit_profile.dart';
import 'package:start_pro/features/home/view/widgets/settings/settings_section.dart';
import 'package:start_pro/features/home/view/widgets/settings/settings_tile.dart';
import 'package:start_pro/features/home/view/widgets/settings/appearance_buttons.dart';
import 'package:start_pro/features/home/view/widgets/settings/settings_dialog.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(bottom: 32),
        children: [
          SettingsSection(
            title: Locales.string(context, 'profile_settings'),
            children: [
              SettingsTile(
                leading: const Icon(Icons.person_outline),
                title: Text(Locales.string(context, 'edit_profile')),
                subtitle: Text(Locales.string(context, 'change_profile_info')),
                onTap:
                    () => Navigator.pushNamed(context, EditProfilePage.route),
              ),
              SettingsTile(
                leading: const Icon(Icons.image_outlined),
                title: Text(Locales.string(context, 'change_avatar')),
                onTap: () {
                  // Navigate to avatar change screen
                },
              ),
            ],
          ),
          SettingsSection(
            title: Locales.string(context, 'appearance'),
            children: [
              AppearanceButtons(
                onThemeToggle:
                    () => AdaptiveTheme.of(context).toggleThemeMode(),
                onLanguageToggle: () => swapLanguage(context),
              ),
            ],
          ),
          SettingsSection(
            title: Locales.string(context, 'account_management'),
            children: [
              SettingsTile(
                leading: const Icon(Icons.security),
                title: Text(Locales.string(context, 'security')),
                subtitle: Text(
                  Locales.string(context, 'password_and_security'),
                ),
                onTap: () {
                  // Navigate to security settings
                },
              ),
              SettingsTile(
                leading: const Icon(Icons.notifications_outlined),
                title: Text(Locales.string(context, 'notifications')),
                onTap: () {
                  // Navigate to notifications settings
                },
              ),
              SettingsTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: Text(Locales.string(context, 'privacy')),
                onTap: () {
                  // Navigate to privacy settings
                },
              ),
            ],
          ),
          SettingsSection(
            title: Locales.string(context, 'support'),
            children: [
              SettingsTile(
                leading: const Icon(Icons.help_outline),
                title: Text(Locales.string(context, 'help_center')),
                onTap: () {
                  // Navigate to help center
                },
              ),
              SettingsTile(
                leading: const Icon(Icons.bug_report_outlined),
                title: Text(Locales.string(context, 'report_bug')),
                onTap: () {
                  // Navigate to bug report
                },
              ),
            ],
          ),
          SettingsSection(
            title: Locales.string(context, 'danger_zone'),
            children: [
              SettingsTile(
                leading: Icon(Icons.logout, color: AppColors.kErrorColor),
                title: Text(
                  Locales.string(context, 'logout'),
                  style: TextStyle(color: AppColors.kErrorColor),
                ),
                onTap: () {
                  // Show logout confirmation dialog
                  _showLogoutDialog(context);
                },
              ),
              SettingsTile(
                leading: Icon(
                  Icons.delete_forever,
                  color: AppColors.kErrorColor,
                ),
                title: Text(
                  Locales.string(context, 'delete_account'),
                  style: TextStyle(color: AppColors.kErrorColor),
                ),
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
            ],
          ),
          SettingsSection(
            title: Locales.string(context, 'about'),
            children: [
              SettingsTile(
                leading: const Icon(Icons.info_outline),
                title: Text(Locales.string(context, 'app_version')),
                subtitle: const Text('0.0.1'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => SettingsDialog(
            title: Locales.string(context, 'logout_confirmation'),
            content: Locales.string(context, 'logout_message'),
            cancelText: Locales.string(context, 'cancel'),
            confirmText: Locales.string(context, 'logout'),
            onConfirm: () => logout(context),

            confirmColor: AppColors.kErrorColor,
          ),
    );
  }

  Future<void> _showDeleteAccountDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder:
          (context) => SettingsDialog(
            title: Locales.string(context, 'delete_account_confirmation'),
            content: Locales.string(context, 'delete_account_message'),
            cancelText: Locales.string(context, 'cancel'),
            confirmText: Locales.string(context, 'delete'),
            onConfirm: () => logout(context),
            confirmColor: AppColors.kErrorColor,
          ),
    );
  }
}
