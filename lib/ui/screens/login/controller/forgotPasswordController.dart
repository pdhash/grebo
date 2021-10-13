import 'package:flutter/material.dart';
import 'package:grebo/core/models/successModel.dart';
import 'package:grebo/core/service/repo/userRepo.dart';

import '../../../global.dart';

class ForgotPasswordController {
  final TextEditingController email = TextEditingController();
  SuccessModel? successModel;
  Future userForgotPassword() async {
    var response = await UserRepo.userForgotPassword(
        email: email.text.trim(),
        userType: getServiceTypeCode(serviceController.servicesType));
    successModel = SuccessModel.fromJson(response);
  }
}
