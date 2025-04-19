import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:start_pro/core/constants/routes.dart';
import 'package:start_pro/core/theme/theme.dart';
import 'package:start_pro/features/router/view/pages/router_page.dart';

class MyApp extends StatelessWidget {
  final ThemeData theme;
  final ThemeData darkTheme;

  const MyApp({
    super.key,
    required this.theme,
    required this.darkTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => LocaleBuilder(
        builder: (locale) => MaterialApp(
          title: 'StartPro',
          debugShowCheckedModeBanner: false,
          routes: routes,
          initialRoute: RouterPage.route,
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          theme: theme,
          darkTheme: darkTheme,
        ),
      ),
    );
  }
}
