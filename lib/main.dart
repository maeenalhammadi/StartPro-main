import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'package:start_pro/core/config/firebase_options.dart';
import 'package:start_pro/core/theme/theme.dart';
import 'package:start_pro/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تحميل ملفات البيئة (.env)
  await dotenv.load(fileName: '.env');

  // تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // تهيئة اللغات
  await Locales.init(['en', 'ar']);

  // تشغيل التطبيق مع AdaptiveTheme و ProviderScope
  runApp(
    AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => ProviderScope(
        child: MyApp(
          theme: theme,
          darkTheme: darkTheme,
        ),
      ),
    ),
  );
}
