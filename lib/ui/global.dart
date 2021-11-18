import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/googleAdd/addServices.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/messagesTab/allmessages.dart';
import 'package:grebo/ui/screens/notifications/notifications.dart';
import 'package:grebo/ui/screens/profile/profile.dart';
import 'package:grebo/ui/shared/userController.dart';

import 'screens/homeTab/widget/guestLoginView.dart';

List<Widget> tabNavigation = [
  Home(),
  AllMessages(),
  AllNotification(),
  Profile(),
];
List<Widget> tabNavigationForGuest = [
  Home(),
  GuestLoginView(),
  GuestLoginView(),
  GuestLoginView(),
];
late AppImagePicker appImagePicker;

globalVerbsInit() async {
  userController = Get.put(UserController());
  appImagePicker = AppImagePicker();
  GoogleAddService.createInterstitialAd();
}

int initialTab = 0;
late bool navigationScreen;
