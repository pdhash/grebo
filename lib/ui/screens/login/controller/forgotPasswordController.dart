import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/models/successModel.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController email = TextEditingController();
  SuccessModel? successModel;
  Future userForgotPassword() async {
    final ServiceController serviceController = Get.find<ServiceController>();

    var response = await UserRepo.userForgotPassword(
        email: email.text.trim(),
        userType: getServiceTypeCode(serviceController.servicesType));
    successModel = SuccessModel.fromJson(response);
  }
}
