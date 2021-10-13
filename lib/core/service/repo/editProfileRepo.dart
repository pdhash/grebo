import 'dart:convert';

import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

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

  static Future<List<Category>> getCategories() async {
    var responseBody =
        await API.apiHandler(url: APIRoutes.categoryList, showLoader: false);
    if (responseBody != null)
      return List<Category>.from(
          responseBody["data"].map((x) => Category.fromJson(x)));
    else
      return [Category()];
  }
}
