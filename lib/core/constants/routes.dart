import 'package:flutter/material.dart';
import 'package:start_pro/features/auth/view/pages/login_page.dart';
import 'package:start_pro/features/auth/view/pages/register_page.dart';
import 'package:start_pro/features/router/view/pages/router_page.dart';
import 'package:start_pro/features/home/view/pages/home_page.dart';
import 'package:start_pro/features/home/view/pages/edit_profile.dart';
import 'package:start_pro/features/home/view/screens/logo_generator_screen.dart';
import 'package:start_pro/features/home/view/screens/colors_screen.dart';
import 'package:start_pro/features/home/view/screens/sales_prediction_screen.dart';
import 'package:start_pro/features/home/view/screens/name_generator_screen.dart';
import 'package:start_pro/features/home/view/screens/trend_analysis_screen.dart';
import 'package:start_pro/features/home/view/screens/saudi_regulations_screen.dart';
import 'package:start_pro/features/home/view/screens/user_manual_screen.dart'; // ✅ جديد
import 'package:start_pro/features/home/view/screens/security_screen.dart';
import 'package:start_pro/features/home/view/screens/change_password_screen.dart';
import 'package:start_pro/features/home/view/screens/help_center_screen.dart';
import 'package:start_pro/features/home/view/screens/delete_account_screen.dart';

// ...



Map<String, Widget Function(BuildContext)> routes = {
  RouterPage.route: (context) => const RouterPage(),
  LoginPage.route: (context) => const LoginPage(),
  RegisterPage.route: (context) => const RegisterPage(),
  HomePage.route: (context) => const HomePage(),
  EditProfilePage.route: (context) => const EditProfilePage(),
  LogoGeneratorScreen.route: (context) => const LogoGeneratorScreen(),
  ColorsScreen.route: (context) => const ColorsScreen(),
  SalesPredictionScreen.route: (context) => SalesPredictionScreen(),
  NameGeneratorScreen.route: (context) => const NameGeneratorScreen(),
  TrendAnalysisScreen.route: (context) => const TrendAnalysisScreen(),
  SaudiRegulationsScreen.route: (context) => const SaudiRegulationsScreen(),
  UserManualScreen.route: (context) => const UserManualScreen(), // ✅ أضفنا هنا
  SecurityScreen.route: (context) => const SecurityScreen(),
ChangePasswordScreen.route: (context) => ChangePasswordScreen(),
HelpCenterScreen.route: (context) => const HelpCenterScreen(),
DeleteAccountScreen.route: (context) => const DeleteAccountScreen(),
};
