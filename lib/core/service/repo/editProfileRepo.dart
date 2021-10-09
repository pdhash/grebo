import 'dart:convert';

import '../../../main.dart';
import '../apiHandler.dart';
import '../apiRoutes.dart';

class EditProfileRepo {
  static Future updateUser({
    String? businessName,
    String? userName,
    List<String>? image,
    List<String>? websites,
    DateTime? startTime,
    DateTime? endTime,
    String? phoneCode,
    String? mobileNumber,
    String? address,
    String? desc,
    List<int>? workingDays,
  }) async {
    String field = jsonEncode({
      "name": "userName",
      "businessName": businessName,
      "images": image,
      "address": "Default",
      "latitude": 1,
      "longitude": 2,
      "websites": websites,
      "startTime": startTime,
      "endTime": endTime,
      "phoneCode": phoneCode,
      "phoneNumber": mobileNumber,
      "categories": ["6130e78684b74607a67617cb", "6130e7c484b74607a67617cf"],
      "workingDays": workingDays,
      "description": desc
    });
    var responseBody = await API.multiPartAPIHandler(
        url: APIRoutes.userUpdate,
        header: {'Authorization': userController.userToken},
        field: {"data": field});
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }
}
