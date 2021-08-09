import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/app_assets.dart';

AppBar appBar(String title, [List<Widget>? actions]) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    leadingWidth: 50,
    automaticallyImplyLeading: false,
    leading: IconButton(
      splashRadius: 10,
      focusNode: FocusNode(canRequestFocus: false),
      enableFeedback: false,
      icon: SvgPicture.asset(
        AppImages.back,
      ),
      onPressed: () {
        Get.back();
      },
    ),
    actions: actions == null ? [] : actions,
    title: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    ),
    backgroundColor: Colors.white,
  );
}
