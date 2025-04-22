import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:start_pro/core/theme/palette.dart';

class TrendAnalysisScreen extends StatefulWidget {
  static const route = '/trend-analysis';

  const TrendAnalysisScreen({super.key});

  @override
  State<TrendAnalysisScreen> createState() => _TrendAnalysisScreenState();
}

class _TrendAnalysisScreenState extends State<TrendAnalysisScreen> {
  String? selectedCategory;

  final Map<String, List<String>> categoryImages = {
    'Energy': ['assets/images/energy1.png', 'assets/images/energy2.png'],
    'Health care': ['assets/images/health1.png', 'assets/images/health2.png'],
    'Real Estate': [
      'assets/images/realestate1.png',
      'assets/images/realestate2.png',
    ],
    'Food': ['assets/images/food1.png', 'assets/images/food2.png'],
    'Beverages': [
      'assets/images/beverages1.png',
      'assets/images/beverages2.png',
    ],
    'Transportation': [
      'assets/images/transport1.png',
      'assets/images/transport2.png',
    ],
    'Education': [
      'assets/images/education1.png',
      'assets/images/education2.png',
    ],
    'Art': ['assets/images/art1.png', 'assets/images/art2.png'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        title: LocaleText('trendAnalysis'),
        backgroundColor: AppColors.kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a sector',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView(
                children: [
                  ...categoryImages.keys.map((category) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 14.h,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                  if (selectedCategory != null) ...[
                    SizedBox(height: 24.h),
                    Scrollbar(
                      thumbVisibility: true,
                      thickness: 6,
                      radius: Radius.circular(8.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            categoryImages[selectedCategory!]!
                                .map(
                                  (imagePath) => Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: Image.asset(imagePath),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
