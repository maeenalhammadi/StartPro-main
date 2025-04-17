import 'package:flutter/material.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/theme/palette.dart';
import 'package:start_pro/features/home/view/screens/home_screen.dart';
import 'package:start_pro/features/home/view/screens/search_screen.dart';
import 'package:start_pro/features/home/view/screens/settings_screen.dart';

class HomePage extends ConsumerStatefulWidget {
  static const route = '/home';
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  // Pages to display
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const SettingsScreen(),
  ];

  void _handleNavigationChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: FluidNavBar(
              icons: [
                FluidNavBarIcon(icon: Icons.home_outlined),
                FluidNavBarIcon(icon: Icons.explore_outlined),
                FluidNavBarIcon(icon: Icons.settings_outlined),
              ],
              onChange: _handleNavigationChange,
              style: FluidNavBarStyle(
                barBackgroundColor: AppColors.kBackgroundLightColor,
                iconSelectedForegroundColor: AppColors.kTextColor,
              ),
              scaleFactor: 1.5,
              defaultIndex: _currentIndex,
              animationFactor: 0.6,
            ),
          ),
          Container(height: 10.h, color: AppColors.kBackgroundLightColor),
        ],
      ),
    );
  }
}
