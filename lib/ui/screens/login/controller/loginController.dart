import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/auth/googleAuth.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/baseScreen/baseScreen.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  RxBool showText = true.obs;
  CurrentUserModel? currentUserModel;

  Future userLogin() async {
    final ServiceController serviceController = Get.find<ServiceController>();

    var response = await UserRepo.userLogin(
        email: email.text.trim(),
        password: password.text.trim(),
        userType: serviceController.servicesType == ServicesType.providerType
            ? 2
            : 1);
    if (response != null) {
      print(response);

      currentUserModel = CurrentUserModel.fromJson(response);
      saveUserDetails(currentUserModel!.data);

      Get.offAll(() => BaseScreen());
    }
  }

  Future socialLogin() async {
    final ServiceController serviceController = Get.find<ServiceController>();
    String socialId = "";
    User? userFireBase;

    await GoogleAuth.signInWithGoogle().then((value) async {
      if (value != null) {
        socialId = await value.getIdToken();
        userFireBase = value;
      }
    });

    var response = await UserRepo.userSocialLogin(
        name: userFireBase!.displayName.toString(),
        userType: getServiceTypeCode(serviceController.servicesType),
        email: userFireBase!.email.toString(),
        fcmToken: "12345",
        image: userFireBase!.photoURL.toString(),
        socialId: userFireBase!.uid,
        socialToken: socialId,
        socialIdentifier: getSocialIdentifier(SocialIdentifier.Google));
    if (response != null) {
      print(response);

      currentUserModel = CurrentUserModel.fromJson(response);
      saveUserDetails(currentUserModel!.data);

      Get.offAll(() => BaseScreen());
    }
  }
}

enum SocialIdentifier { FaceBook, Google, Apple }

int getSocialIdentifier(SocialIdentifier socialIdentifier) {
  int code;
  switch (socialIdentifier) {
    case SocialIdentifier.FaceBook:
      code = 1;
      break;
    case SocialIdentifier.Google:
      code = 2;
      break;
    case SocialIdentifier.Apple:
      code = 3;
      break;
  }
  return code;
}
