import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/constants/env.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/features/home/models/business.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:start_pro/features/home/view/screens/business_screen.dart';

class BusinessCard extends StatelessWidget {
  const BusinessCard({super.key, required this.business});

  final BusinessModel business;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.kSurfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessScreen(business: business),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Image
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.kSurfaceColorLight,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          business.imageUrl != null
                              ? Hero(
                                tag: business.imageUrl!,
                                child: CachedNetworkImage(
                                  imageUrl: Env.strapiUrl + business.imageUrl!,
                                  fit: BoxFit.fitWidth,
                                  placeholder:
                                      (context, url) => Container(
                                        color: AppColors.kSurfaceColorLight,
                                        child: Center(
                                          child: Icon(
                                            Icons.business,
                                            size: 32.w,
                                            color: AppColors.kTextTertiaryColor,
                                          ),
                                        ),
                                      ),
                                  errorWidget:
                                      (context, error, stackTrace) => Container(
                                        color: AppColors.kSurfaceColorLight,
                                        child: Center(
                                          child: Icon(
                                            Icons.error_outline,
                                            size: 32.w,
                                            color: AppColors.kErrorColor,
                                          ),
                                        ),
                                      ),
                                ),
                              )
                              : Container(
                                color: AppColors.kSurfaceColorLight,
                                child: Center(
                                  child: Icon(
                                    Icons.business,
                                    size: 32.w,
                                    color: AppColors.kTextTertiaryColor,
                                  ),
                                ),
                              ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  // Company Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company Name
                        Text(
                          business.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kTextColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryColor.withAlpha(10),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            business.typeLabel,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Description
                        Text(
                          business.description ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.kTextSecondaryColor,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
