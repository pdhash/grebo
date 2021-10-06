import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grebo/core/constants/app_theme.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/baseScreen/baseScreen.dart';
import 'package:grebo/ui/screens/onbording.dart';
import 'package:grebo/ui/shared/userController.dart';

import 'core/utils/lang.dart';
import 'core/utils/sharedpreference.dart';
import 'core/viewmodel/controller/imagepickercontoller.dart';

late final UserController userController;

void main() async {
  await GetStorage.init();
  globalVerbsInit();
  userController = Get.put(UserController());
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
        child: child as Widget,
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Grebo',
      home: getUserDetail() ? BaseScreen() : OnBoarding(),
      translations: Lang(),
      theme: AppTheme.defTheme,
      locale: Locale('en', 'US'), //Localizations.localeOf(context),
      fallbackLocale: Locale('en', 'US'),
    );
  }
}
