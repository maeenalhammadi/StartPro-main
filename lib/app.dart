import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:start_pro/core/constants/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:start_pro/core/theme/theme.dart';
import 'package:start_pro/features/router/view/pages/router_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder:
        (_, child) => AdaptiveTheme(
          light: AppTheme.darkTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.dark,
          builder:
              (theme, darkTheme) => LocaleBuilder(
                builder:
                    (locale) => MaterialApp(
                      title: 'StartPro',
                      routes: routes,
                      initialRoute: RouterPage.route,
                      localizationsDelegates: Locales.delegates,
                      supportedLocales: Locales.supportedLocales,
                      locale: locale,
                      theme: theme,
                      darkTheme: darkTheme,
                      debugShowCheckedModeBanner: false,
                    ),
              ),
        ),
  );
}
