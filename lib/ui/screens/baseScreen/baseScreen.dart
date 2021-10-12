import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:grebo/ui/screens/homeTab/controller/homeController.dart';
import 'package:grebo/ui/shared/bottomabar.dart';

import '../../global.dart';
import '../homeTab/home.dart';
import '../homeTab/provider/createpost.dart';

class BaseScreen extends StatelessWidget {
  final HomeController homeScreenController = Get.put(HomeController());
  final BaseController baseController = Get.put(BaseController());
  @override
  Widget build(BuildContext context) {
    print("USER TOKEN ${userController.userToken}");
    return Scaffold(
      appBar: buildAppBar(),
      body: GetBuilder(
          builder: (BaseController controller) =>
              tabNavigation[controller.currentTab]),
      bottomNavigationBar: BuildBottomBar(),
      floatingActionButton: floatingAction(),
    );
  }

  floatingAction() {
    return GetBuilder(
      builder: (BaseController controller) => controller.currentTab == 0
          ? GestureDetector(
              onTap: () {
                Get.to(() => CreatePost());
              },
              child: buildWidget(AppImages.create, 50, 50),
            )
          : SizedBox(),
    );
  }

  AppBar buildAppBar() {
    List<String> appTitle = [
      'feeds'.tr,
      'messages'.tr,
      'notifications'.tr,
      'profile'.tr
    ];
    return AppBar(
      title: GetBuilder(
          builder: (BaseController controller) =>
              Text(appTitle[controller.currentTab])),
    );
  }
}
