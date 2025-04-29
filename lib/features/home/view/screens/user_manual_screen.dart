import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:start_pro/core/theme/palette.dart';

class UserManualScreen extends StatelessWidget {
  static const route = '/user-manual';

  const UserManualScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> manualData = const [
    {
      "image": "assets/images/home_page.png",
      "title_key": "home_page_title",
      "description_key": "home_page_description",
    },
    {
      "image": "assets/images/search_page.png",
      "title_key": "search_page_title",
      "description_key": "search_page_description",
    },
    {
      "image": "assets/images/name_generator.png",
      "title_key": "name_generator_title",
      "description_key": "name_generator_description",
    },
    {
      "image": "assets/images/logo_generator.png",
      "title_key": "logo_generator_title",
      "description_key": "logo_generator_description",
    },
    {
      "image": "assets/images/sales_prediction.png",
      "title_key": "sales_prediction_title",
      "description_key": "sales_prediction_description",
    },
    {
      "image": "assets/images/trend_analysis.png",
      "title_key": "trend_analysis_title",
      "description_key": "trend_analysis_description",
    },
    {
      "image": "assets/images/saudi_laws.png",
      "title_key": "saudi_laws_title",
      "description_key": "saudi_laws_description",
    },
    {
      "image": "assets/images/trade_name_system.png",
      "title_key": "trade_name_system_title",
      "description_key": "trade_name_system_description",
    },
    {
      "image": "assets/images/settings_page.png",
      "title_key": "settings_page_title",
      "description_key": "settings_page_description",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundLightColor,
      appBar: AppBar(
        backgroundColor: AppColors.kBackgroundLightColor,
        elevation: 0,
        title: LocaleText(
          'user_manual',
          style: TextStyle(
            color: AppColors.kTextColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: ListView.builder(
          itemCount: manualData.length,
          itemBuilder: (context, index) {
            final item = manualData[index];
            return Card(
              margin: EdgeInsets.only(bottom: 24.h),
              elevation: 6,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(
                        item['image']!,
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Icon(Icons.bookmark_outline, color: AppColors.kPrimaryColor, size: 24.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: LocaleText(
                            item['title_key']!,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.kTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    LocaleText(
                      item['description_key']!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.kTextLightColor,
                        height: 1.6,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
