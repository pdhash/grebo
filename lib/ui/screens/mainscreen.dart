import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:greboo/ui/screens/profile/profile.dart';
import 'package:greboo/ui/shared/bottomabar.dart';

import 'homeTab/home.dart';
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
      builder: (HomeScreenController controller) => Scaffold(
          appBar: AppBar(
            title: Text(text[controller.current]),
          ),
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: homeScreenController.pageController,
            children: [
              Homes(),
              AllMessages(),
              AllNotification(),
              Profile(),
            ],
          ),
          bottomNavigationBar: BuildBottomBar()),
    );
  }
}
