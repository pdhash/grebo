import 'dart:convert';

import 'package:grebo/core/service/apiHandler.dart';
import 'package:grebo/core/service/apiRoutes.dart';

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

  static Future userSignUp({
    required String email,
    required String name,
    required String password,
    required String image,
    required int userType,
  }) async {
    var responseBody = await API.apiHandler(
      url: APIRoutes.userSignUp,
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
}
