import 'package:flutter/material.dart';
import 'package:start_pro/features/home/models/feature_model.dart';
import 'package:start_pro/features/home/view/screens/colors_screen.dart';
import 'package:start_pro/features/home/view/screens/logo_generator_screen.dart';
import 'package:start_pro/features/home/view/screens/sales_prediction_screen.dart';
import 'package:start_pro/features/home/view/screens/name_generator_screen.dart';
import 'package:start_pro/features/home/view/screens/saudi_regulations_screen.dart'; // 👈 Make sure this is imported
import 'package:start_pro/features/home/view/screens/trend_analysis_screen.dart';
class FeatureSection {
  final String label;
  final List<FeatureItem> items;

  const FeatureSection({required this.label, required this.items});
}

class HomeFeatures {
  static final List<FeatureSection> sections = [
    FeatureSection(
      label: 'ai_tools',
      items: [
        FeatureItem(
          label: 'palette_generator',
          icon: Icons.palette_outlined,
          description: 'create_professional_palettes_with_ai',
          path: ColorsScreen.route,
        ),
        FeatureItem(
          label: 'name_generator',
          icon: Icons.auto_awesome,
          description: 'generate_unique_business_names_using_ai',
          path: NameGeneratorScreen.route, // ✅ updated path
        ),
        FeatureItem(
          label: 'logo_generator',
          icon: Icons.image,
          description: 'create_professional_logos_with_ai',
          path: LogoGeneratorScreen.route,
        ),
      ],
    ),
    FeatureSection(
      label: 'business_tools',
      items: [
 FeatureItem(
  label: 'trend_analysis',
  icon: Icons.analytics_outlined,
  description: 'analyze_business_trends_by_sector',
  path: TrendAnalysisScreen.route,
),


        FeatureItem(
          label: 'sales_prediction',
          icon: Icons.trending_up,
          description: 'forecast_sales_performance',
          path: SalesPredictionScreen.route,
        ),
      ],
    ),
    FeatureSection(
      label: 'Resources',
      items: [
        FeatureItem(
          label: 'saudi_laws',
          icon: Icons.gavel_outlined,
          description: 'access_saudi_business_regulations',
          path: SaudiRegulationsScreen.route, // ✅ updated to use static route
        ),

        FeatureItem(
          label: 'user_manual',
          icon: Icons.menu_book_outlined,
          description: 'download_comprehensive_guides',
          path: '/user-manual',
        ),
      ],
    ),
  ];
}
