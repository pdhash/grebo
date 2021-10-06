import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/messagesTab/allmessages.dart';
import 'package:grebo/ui/screens/notifications/allnotifications.dart';
import 'package:grebo/ui/screens/profile/profile.dart';

final ServiceController serviceController = Get.find<ServiceController>();
List<Widget> tabNavigation = [
  Home(),
  AllMessages(),
  AllNotification(),
  Profile(),
];
late AppImagePicker appImagePicker;

globalVerbsInit() {
  appImagePicker = AppImagePicker();
}
