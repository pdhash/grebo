import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/extension/dateTimeFormatExtension.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

import '../details3.dart';

class AvailabilityController extends GetxController {
  List<int> daysCount = [];

  void addDays(int index) {
    print("add $daysCount");
    daysCount.add(index);
    update();
  }

  void removeDays(int index) {
    daysCount.remove(index);

    update();
  }

  ///=====================
  String _defaultTime = "09:00 AM";

  String get defaultTime => _defaultTime;

  set defaultTime(String value) {
    _defaultTime = value;
    update();
  }

  String _defaultTimeEnd = "06:00 PM";

  String get defaultTimeEnd => _defaultTimeEnd;

  set defaultTimeEnd(String value) {
    _defaultTimeEnd = value;
    update();
  }

  ///=============== DB
  late String _startTime = appTimeFunDB(TimeOfDay(hour: 9, minute: 00));

  String get startTime => _startTime;

  set startTime(String value) {
    _startTime = value;
    update();
  }

  late String _endTime = appTimeFunDB(TimeOfDay(hour: 18, minute: 00));

  String get endTime => _endTime;

  set endTime(String value) {
    _endTime = value;
    update();
  }

  Future submitAllFields(bool isNext) async {
    daysCount.sort();
    var v = await EditProfileRepo.updateUser(
      map: {
        "workingDays": daysCount,
        "startTime": startTime,
        "endTime": endTime,
      },
    );
    if (v != null) {
      print(v);
      updateUserDetail(UserModel.fromJson(v['data']));
      if (isNext) {
        Get.to(() => DetailsPage3());
      } else {
        Get.back();
      }
    }
  }

  @override
  void onInit() {
    if (userController.user.profileCompleted) {
      daysCount = userController.user.workingDays;
      defaultTime = dateFormat
          .format(DateTime.parse(userController.user.startTime).toLocal());
      defaultTimeEnd = dateFormat
          .format(DateTime.parse(userController.user.endTime).toLocal());
      startTime = appTimeFunDB(TimeOfDay.fromDateTime(
          DateTime.parse(userController.user.startTime).toLocal()));
      endTime = appTimeFunDB(TimeOfDay.fromDateTime(
          DateTime.parse(userController.user.endTime).toLocal()));
    }

    super.onInit();
  }
}
