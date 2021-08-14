import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_theme.dart';
import 'package:grebo/ui/screens/onbording.dart';

import 'core/utils/lang.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grebo',
      home: OnBoarding(),
      translations: Lang(),
      theme: AppTheme.defTheme,
      locale: Locale('en', 'US'), //Localizations.localeOf(context),
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
