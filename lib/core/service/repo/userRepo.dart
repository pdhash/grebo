import 'dart:convert';
import 'dart:io';

import 'package:grebo/core/service/apiHandler.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';

class UserRepo {
  static Future userLogin({
    required String email,
    required String password,
    required int userType,
  }) async {
    var responseBody = await API.apiHandler(
      url: APIRoutes.userLogin,
      header: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {"email": email, "password": password, "userType": userType},
      ),
    );
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }

  static Future userSocialLogin({
    required String name,
    required int userType,
    required String email,
    required String fcmToken,
    required String image,
    required String socialId,
    required String socialToken,
    required int socialIdentifier,
  }) async {
    var responseBody = await API.apiHandler(
      url: APIRoutes.socialLogin,
      header: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {
          "email": email,
          "userType": userType,
          "name": name,
          "device": Platform.isAndroid ? "Android" : "IOS",
          "fcmToken": fcmToken,
          "image": image,
          "referralId":"",
              "socialId": socialId,
          "socialToken": socialToken,
          "socialIdentifier": socialIdentifier
        },
      ),
    );
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }

  static Future userSignUp({
    required String email,
    required String name,
    required String password,
    required File image,
    required int userType,
  }) async {
    var responseBody =
        await API.multiPartAPIHandler(url: APIRoutes.userSignUp, field: {
      "data": jsonEncode({
        "email": email,
        "password": password,
        "userType": userType,
        "name": name
      })
    }, fileImage: [
      image
    ]);
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }

  static Future userForgotPassword({
    required String email,
    required int userType,
  }) async {
    print(email);
    print(userType);
    var responseBody = await API.apiHandler(
      url: APIRoutes.emailVerification,
      requestType: RequestType.Post,
      header: {
        //'Content-Type': contentType(ContentType.jsonType),
        'Content-Type': 'application/json',
      },
      body: jsonEncode(
        {"email": email, "requestType": 2, "userType": userType},
      ),
    );
    if (responseBody != null) return responseBody;
  }
}

int getServiceTypeCode(ServicesType servicesType) {
  int code;
  switch (servicesType) {
    case ServicesType.userType:
      code = 1;
      break;
    case ServicesType.providerType:
      code = 2;
      break;
  }
  return code;
}
