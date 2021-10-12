import 'dart:convert';

import '../../../main.dart';
import '../apiHandler.dart';
import '../apiRoutes.dart';

class EditProfileRepo {
  static Future updateUser({required Map<String, dynamic> map}) async {
    String field = jsonEncode(map);
    var responseBody = await API.multiPartAPIHandler(
        url: APIRoutes.userUpdate,
        header: {'Authorization': userController.userToken},
        field: {"data": field});
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }

  static Future serviceUpdate({required Map<String, dynamic> map}) async {
    String field = jsonEncode(map);
    var responseBody = await API.apiHandler(
        url: APIRoutes.addServices,
        header: {"Authorization": userController.userToken},
        body: field);
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }
}