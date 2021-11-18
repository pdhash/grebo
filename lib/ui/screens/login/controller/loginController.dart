import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/service/auth/googleAuth.dart';
import 'package:grebo/core/service/repo/userRepo.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/baseScreen/baseScreen.dart';
import 'package:grebo/ui/screens/editBusinessprofile/details1.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';
import 'package:grebo/ui/shared/loader.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  RxBool showText = true.obs;
  CurrentUserModel? currentUserModel;

  Future userLogin() async {
    final ServiceController serviceController = Get.find<ServiceController>();
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    var response = await UserRepo.userLogin(
        email: email.text.trim(),
        password: password.text.trim(),
        userType:
            serviceController.servicesType == ServicesType.providerType ? 2 : 1,
        fcmToken: fcmToken.toString());
    if (response != null) {
      userController.isGuest = false;

      currentUserModel = CurrentUserModel.fromJson(response);
      saveUserDetails(currentUserModel!.data);

      if (currentUserModel!.data.user.userType ==
          getServiceTypeCode(ServicesType.providerType)) {
        if (currentUserModel!.data.user.profileCompleted) {
          Get.offAll(() => BaseScreen());
        } else {
          Get.offAll(() => DetailsPage1());
        }
      } else {
        Get.offAll(() => BaseScreen());
      }
    }
  }

  Future googleLogin() async {
    LoadingOverlay.of().show();

    final ServiceController serviceController = Get.find<ServiceController>();
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      await GoogleAuth.signInWithGoogle().then((data) async {
        if (data == null) return;
        User userFireBase = data["user"];
        if (userFireBase != null) {
          var response = await UserRepo.userSocialLogin(
              name: userFireBase.displayName.toString(),
              userType: getServiceTypeCode(serviceController.servicesType),
              email: userFireBase.email.toString(),
              fcmToken: fcmToken.toString(),
              image: userFireBase.photoURL.toString(),
              socialId: data["socialId"],
              socialToken: data["token"],
              socialIdentifier: getSocialIdentifier(SocialIdentifier.Google));
          if (response != null) {
            userController.isGuest = false;
            currentUserModel = CurrentUserModel.fromJson(response);
            saveUserDetails(currentUserModel!.data);
            LoadingOverlay.of().hide();
            if (currentUserModel!.data.user.userType ==
                getServiceTypeCode(ServicesType.providerType)) {
              if (currentUserModel!.data.user.profileCompleted) {
                Get.offAll(() => BaseScreen());
              } else {
                Get.offAll(() => DetailsPage1());
              }
            } else {
              Get.offAll(() => BaseScreen());
            }
          }
        }
      }).then((value) {
        if (value == null) LoadingOverlay.of().hide();
      });
    } else
      LoadingOverlay.of().hide();
  }

  Future appleLogin() async {
    LoadingOverlay.of().show();
    final ServiceController serviceController = Get.find<ServiceController>();
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    var response;
    if (fcmToken != null) {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      ).catchError((e) {
        LoadingOverlay.of().hide();
      });
      response = await UserRepo.userSocialLogin(
          name: credential.givenName.toString(),
          userType: getServiceTypeCode(serviceController.servicesType),
          email: credential.email.toString(),
          fcmToken: fcmToken.toString(),
          socialId: credential.userIdentifier.toString(),
          socialToken: credential.identityToken.toString(),
          socialIdentifier: getSocialIdentifier(SocialIdentifier.Apple));
    }

    if (response != null) {
      userController.isGuest = false;
      currentUserModel = CurrentUserModel.fromJson(response);
      saveUserDetails(currentUserModel!.data);
      LoadingOverlay.of().hide();
      if (currentUserModel!.data.user.userType ==
          getServiceTypeCode(ServicesType.providerType)) {
        if (currentUserModel!.data.user.profileCompleted) {
          Get.offAll(() => BaseScreen());
        } else {
          Get.offAll(() => DetailsPage1());
        }
      } else {
        Get.offAll(() => BaseScreen());
      }
    }
    LoadingOverlay.of().hide();
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
