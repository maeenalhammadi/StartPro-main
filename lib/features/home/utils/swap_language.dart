import 'package:flutter/widgets.dart';
import 'package:flutter_locales/flutter_locales.dart';

void swapLanguage(BuildContext context) {
  final currentLocale = context.currentLocale?.toString() ?? 'en';

  switch (currentLocale) {
    case String locale when locale.startsWith('en'):
      Locales.change(context, 'ar');
    case String locale when locale.startsWith('ar'):
      Locales.change(context, 'en');
    default:
      Locales.change(context, 'en');
  }
}
