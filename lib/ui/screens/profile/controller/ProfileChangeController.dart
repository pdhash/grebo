import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

import '../../../../main.dart';

class ProfileChangeController extends GetxController {
  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController location = TextEditingController();

  Future updateUser() async {
    EditProfileRepo.updateUser(map: {
      "name": name.text.trim(),
    }, image: appImagePicker.imagePickerController.image)
        .then((v) {
      if (v != null) {
        appImagePicker.imagePickerController.resetImage();
        updateUserDetail(User.fromJson(v['data']));
        flutterToast(v["message"]);
        Get.back();
      }
    });
  }

  @override
  void onInit() {
    name.text = userController.user.name;
    email.text = userController.user.email;

    super.onInit();
  }
}
