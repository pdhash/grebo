import 'dart:convert';

import 'package:get/get.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:http/http.dart' as http;

enum RequestType { Get, Post }

class API {
  static late http.Response response;

  static Future apiHandler({
    required String url,
    RequestType requestType = RequestType.Post,
    Map<String, String>? header,
    dynamic body,
  }) async {
    try {
      bool connection = await checkConnection();
      if (connection) {
        if (requestType == RequestType.Get) {
          response = await http.get(
            Uri.parse(url),
            headers: header,
          );
        } else {
          response =
              await http.post(Uri.parse(url), headers: header, body: body);
        }

        if (response.body.isNotEmpty) {
          var res = jsonDecode(response.body);
          if (res["code"] == 100) {
            return response.body;
          } else {
            flutterToast(res["message"]);
          }
        } else {
          return null;
        }
      } else
        flutterToast('check_your_connection'.tr);
      return null;
    } catch (e) {
      print("ERROR FROM API CLASS $e");
    }
  }
}
