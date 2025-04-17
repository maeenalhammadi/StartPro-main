import 'package:flutter/material.dart';
import 'package:start_pro/core/theme/palette.dart';

Color getColorForIndex(int index) {
  final colors = [
    AppColors.kAccentYellow,
    AppColors.kSuccessColor,
    AppColors.kSecondaryColor,
    AppColors.kAccentOrange,
    AppColors.kInfoColor,
  ];
  return colors[index % colors.length];
}
