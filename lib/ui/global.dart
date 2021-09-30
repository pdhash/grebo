import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/screens/messagesTab/allmessages.dart';
import 'package:grebo/ui/screens/notifications/allnotifications.dart';
import 'package:grebo/ui/screens/profile/profile.dart';

final ServiceController serviceController = Get.find<ServiceController>();
List<Widget> tabNavigation = [
  Homes(),
  AllMessages(),
  AllNotification(),
  Profile(),
];
