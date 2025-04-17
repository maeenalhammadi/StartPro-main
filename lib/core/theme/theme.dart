import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:start_pro/core/theme/palette.dart';

class AppTheme {
  static Map<int, Color> kMainMaterialColor = {
    50: AppColors.kPrimaryColor.withValues(alpha: .1),
    100: AppColors.kPrimaryColor.withValues(alpha: .2),
    200: AppColors.kPrimaryColor.withValues(alpha: .3),
    300: AppColors.kPrimaryColor.withValues(alpha: .4),
    400: AppColors.kPrimaryColor.withValues(alpha: .5),
    500: AppColors.kPrimaryColor.withValues(alpha: .6),
    600: AppColors.kPrimaryColor.withValues(alpha: .7),
    700: AppColors.kPrimaryColor.withValues(alpha: .8),
    800: AppColors.kPrimaryColor.withValues(alpha: .9),
    900: AppColors.kPrimaryColor.withValues(alpha: 1),
  };

  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.cairo().fontFamily,
    platform: TargetPlatform.android,
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.kPrimaryColor,
      secondary: AppColors.kSecondaryColor,
      surface: AppColors.kSurfaceColor,
      onPrimary: AppColors.kTextColor,
      onSecondary: AppColors.kTextColor,
      onSurface: AppColors.kTextColor,
      error: AppColors.kErrorColor,
      onError: AppColors.kTextColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.cairo().fontFamily,
    platform: TargetPlatform.android,
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.kPrimaryColor,
      secondary: AppColors.kSecondaryColor,
      surface: AppColors.kSurfaceColor,
      onPrimary: AppColors.kTextColor,
      onSecondary: AppColors.kTextColor,
      onSurface: AppColors.kTextColor,
      error: AppColors.kErrorColor,
      onError: AppColors.kTextColor,
      background: AppColors.kBackgroundColor,
      onBackground: AppColors.kTextColor,
    ),
    scaffoldBackgroundColor: AppColors.kBackgroundColor,
    cardColor: AppColors.kSurfaceColor,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.kTextColor),
      bodyMedium: TextStyle(color: AppColors.kTextSecondaryColor),
      bodySmall: TextStyle(color: AppColors.kTextTertiaryColor),
    ),
  );
}
