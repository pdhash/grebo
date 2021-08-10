import 'package:flutter/material.dart';
import 'package:greboo/core/constants/appSetting.dart';

import 'appcolor.dart';

class AppTheme {
  static final ThemeData defTheme = ThemeData(
    //visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: Colors.white,
    primaryIconTheme: IconThemeData(color: Colors.black),
    fontFamily: kAppFont,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      brightness: Brightness.light,
      centerTitle: true,
      actionsIconTheme: IconThemeData(size: 16, color: Colors.black),
      textTheme: TextTheme(
          headline6: TextStyle(
              color: AppColor.kDefaultFontColor,
              fontFamily: 'Nexa',
              fontSize: 20,
              fontWeight: FontWeight.w700)),
    ),
    textTheme: TextTheme(
        bodyText2: TextStyle(
      color: AppColor.kDefaultFontColor,
    )),
  );
}
