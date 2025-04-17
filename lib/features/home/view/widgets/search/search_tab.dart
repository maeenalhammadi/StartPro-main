import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/features/home/controller/selected_tab_provider.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({
    super.key,
    required this.context,
    required this.ref,
    required this.slug,
    required this.label,
    required this.isSelected,
  });

  final BuildContext context;
  final WidgetRef ref;
  final String? slug;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ref.read(selectedTabProvider.notifier).state = slug,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kPrimaryColor : AppColors.kSurfaceColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.kPrimaryColor
                    : AppColors.kTextTertiaryColor.withValues(alpha: 0.3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.kTextTertiaryColor,
            fontSize: 10.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
