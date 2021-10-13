import 'dart:convert';

import '../../../main.dart';
import '../apiHandler.dart';
import '../apiRoutes.dart';

class BusinessDataRepo {
  static Future businessData({
    required String name,
    required String businessName,
    required String address,
    required double latitude,
    required double longitude,
    required String description,
    required String phoneCode,
    required String phoneNumber,
    required List images,
    required List websites,
  }) async {
    var responseBody = await API.apiHandler(
      url: APIRoutes.businessDetail,
      header: {
        'Authorization': userController.userToken,
      },
      body: jsonEncode(
        {
          "data": {
            "name": name,
            "businessName": businessName,
            "images": images,
            "address": address,
            "latitude": latitude,
            "longitude": longitude,
            "websites": websites,
            "startTime": "2021-09-03T06:30:00.000Z",
            "endTime": "2021-09-03T18:29:59.000Z",
            "phoneCode": phoneCode,
            "phoneNumber": phoneNumber,
            "categories": [
              "6130e78684b74607a67617cb",
              "6130e7c484b74607a67617cf"
            ],
            "workingDays": [1, 2, 3],
            "description": description
          }
        },
      ),
    );
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }
}
