import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:gap/gap.dart';

class AppearanceButtons extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageToggle;

  const AppearanceButtons({
    super.key,
    required this.onThemeToggle,
    required this.onLanguageToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(Icons.dark_mode, color: AppColors.kTextColor),
              label: LocaleText(
                'toggle_theme',
                style: TextStyle(
                  color: AppColors.kTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // TODO: Next Release
             onPressed: onThemeToggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kAccentPurple,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.language, color: AppColors.kTextColor),
              label: LocaleText(
                'change_language',
                style: TextStyle(
                  color: AppColors.kTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: onLanguageToggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.kAccentYellow,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
