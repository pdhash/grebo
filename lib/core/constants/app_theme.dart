import 'package:flutter/material.dart';
import 'package:greboo/core/constants/appSetting.dart';

class AppTheme {
  static final ThemeData defTheme = ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      scaffoldBackgroundColor: Colors.white,
      primaryIconTheme: IconThemeData(color: Colors.black),
      fontFamily: kAppFont,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent
      // appBarTheme: AppBarTheme(
      //   actionsIconTheme: IconThemeData(opacity: 0),
      //   elevation: 0,
      //   color: Colors.transparent,
      //   brightness: Brightness.light,
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //   ),
      //   centerTitle: true,
      //   textTheme: TextTheme(
      //       headline6: TextStyle(
      //           color: AppColor.kDefaultFontColor,
      //           fontFamily: 'Nexa',
      //           fontSize: 20,
      //           fontWeight: FontWeight.w700)),
      // ),
      // textTheme: TextTheme(
      //     bodyText2: TextStyle(
      //         color: AppColor.textColor, fontWeight: FontWeight.w500)),
      // textSelectionTheme:
      //     TextSelectionThemeData(cursorColor: AppColor.textColor),
      // errorColor: Colors.red
      );
}
