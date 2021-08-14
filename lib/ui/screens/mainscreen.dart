import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:grebo/ui/screens/profile/profile.dart';
import 'package:grebo/ui/shared/bottomabar.dart';

import 'homeTab/home.dart';
import 'homeTab/provider/createpost.dart';
import 'messagesTab/allmessages.dart';
import 'notifications/allnotifications.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    List<String> text = [
      'feeds'.tr,
      'messages'.tr,
      'notifications'.tr,
      'profile'.tr
    ];
    return GetBuilder(
      builder: (HomeScreenController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(text[controller.current]),
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (val) => controller.pageChanged = val,
            controller: homeScreenController.pageController,
            children: [
              Homes(),
              AllMessages(),
              AllNotification(),
              Profile(),
            ],
          ),
          bottomNavigationBar: BuildBottomBar(),
          floatingActionButton: controller.pageChanged == 0
              ? GestureDetector(
                  onTap: () {
                    Get.to(() => CreatePost());
                  },
                  child: buildWidget(AppImages.create, 50, 50),
                )
              : SizedBox(),
        );
      },
    );
  }
}
