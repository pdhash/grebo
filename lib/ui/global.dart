import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/messagesTab/allmessages.dart';
import 'package:grebo/ui/screens/notifications/notifications.dart';
import 'package:grebo/ui/screens/profile/profile.dart';
import 'package:grebo/ui/shared/userController.dart';

List<Widget> tabNavigation = [
  Home(),
  AllMessages(),
  AllNotification(),
  Profile(),
];
late AppImagePicker appImagePicker;

globalVerbsInit() async {
  userController = Get.put(UserController());
  appImagePicker = AppImagePicker();
}
