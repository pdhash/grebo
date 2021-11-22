import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';

class LikeError extends StatelessWidget {
  final BaseController baseController = Get.find<BaseController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: ''),
      body: Column(
        children: [
          Spacer(),
          Align(
              alignment: Alignment.centerLeft,
              child: buildWidget(AppImages.error, 328, 354)),
          getHeightSizedBox(h: 29),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'like_error'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: getProportionateScreenWidth(18)),
            ),
          ),
          getHeightSizedBox(h: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
                type: CustomButtonType.colourButton,
                text: 'go_to_profile'.tr,
                onTap: () {
                  Get.back();
                  baseController.currentTab = 3;
                }),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
