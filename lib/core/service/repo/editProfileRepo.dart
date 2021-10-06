import 'dart:convert';

import '../../../main.dart';
import '../apiHandler.dart';
import '../apiRoutes.dart';

class EditProfileRepo {
  static Future editProfile({
    required String name,
    required String image,
  }) async {
    var responseBody = await API.apiHandler(
      url: APIRoutes.businessDetail,
      header: {
        'Authorization': userController.userToken,
      },
      body: jsonEncode(
        {
          "data": {'_id': ''}
        },
      ),
    );
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }
}
