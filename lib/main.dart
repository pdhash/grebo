import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/app_theme.dart';
import 'package:greboo/ui/screens/mainscreen.dart';

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
      home: HomeScreen(),
      translations: Lang(),
      theme: AppTheme.defTheme,
      locale: Locale('en', 'US'), //Localizations.localeOf(context),
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
