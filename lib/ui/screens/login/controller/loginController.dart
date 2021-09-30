import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';
import 'package:grebo/ui/shared/loader.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  RxBool showText = true.obs;
  CurrentUserModel? currentUserModel;

  Future userLogin() async {
    LoadingOverlay.of().show();
    var response = await UserRepo.userLogin(
        email: email.text.trim(),
        password: password.text.trim(),
        userType: serviceController.servicesType == ServicesType.providerType
            ? 2
            : 1);
    LoadingOverlay.of().hide();

    currentUserModel = currentUserModelFromJson(response);
    saveUserDetails(currentUserModel!.data);
  }
}
