import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/widgets/widgets.dart';
import 'package:start_pro/features/home/data/features.dart';
import 'package:start_pro/features/home/utils/get_color_for_index.dart';
import 'package:start_pro/features/home/view/widgets/home/category_section.dart';
import 'package:start_pro/features/home/view/widgets/home/feature_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LocaleText(
                        'welcome_to',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(70),
                        ),
                      ),
                      Text(
                        'StartPro',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Logo(
                    size: 32.r,
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              ...HomeFeatures.sections.map(
                (section) => Column(
                  children: [
                    CategorySection(
                      title: context.localeString(section.label),
                      features:
                          section.items
                              .map(
                                (item) => FeatureCard(
                                  item: item,
                                  color: getColorForIndex(
                                    section.items.indexOf(item) +
                                        HomeFeatures.sections.indexOf(section),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
