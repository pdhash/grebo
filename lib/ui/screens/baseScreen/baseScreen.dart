import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/baseScreen/controller/baseController.dart';
import 'package:grebo/ui/screens/homeTab/provider/likeerror.dart';
import 'package:grebo/ui/shared/bottomabar.dart';
import 'package:grebo/ui/shared/doubleTaptoback.dart';
import 'package:grebo/ui/shared/location.dart';

import '../../global.dart';
import '../homeTab/home.dart';
import '../homeTab/provider/createpost.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final BaseController baseController = Get.put(BaseController());
  @override
  void initState() {
    GetLocationController getLocationController =
        Get.put(GetLocationController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("USER TOKEN ${userController.userToken}");
    return DoubleBackToCloseApp(
      child: Scaffold(
        appBar: buildAppBar(),
        body: GetBuilder(
            builder: (BaseController controller) =>
                tabNavigation[controller.currentTab]),
        bottomNavigationBar: BuildBottomBar(),
        floatingActionButton: userController.user.userType ==
                getServiceTypeCode(ServicesType.providerType)
            ? floatingAction()
            : SizedBox(),
      ),
    );
  }

  floatingAction() {
    return GetBuilder(
      builder: (BaseController controller) => controller.currentTab == 0
          ? GestureDetector(
              onTap: () {
                if (userController.user.verified)
                  Get.to(() => CreatePost());
                else
                  Get.to(() => LikeError());
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
