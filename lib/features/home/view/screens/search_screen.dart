import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/features/home/view/widgets/search/search_input.dart';
import 'package:start_pro/features/home/view/widgets/search/search_tabs.dart';
import 'package:start_pro/features/home/view/widgets/search/search_results.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchInput(),
            SizedBox(height: 12.h),
            SearchTabs(),
            SizedBox(height: 12.h),
            SearchResults(),
          ],
        ),
      ),
    );
  }
}