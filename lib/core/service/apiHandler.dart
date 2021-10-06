import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/ui/shared/loader.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
      if (await checkConnection()) {
        LoadingOverlay.of().show();
        print("URl ===> $url");
        print("HEADER ===> $header");
        print("BODY ===> $body");
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
          print("RESPONSE BODY CREATE");
          var res = jsonDecode(response.body);
          LoadingOverlay.of().hide();

          if (res["code"] == 100) {
            return response.body;
          } else {
            flutterToast(res["message"]);
          }
        } else {
          LoadingOverlay.of().hide();

          return null;
        }
      } else {
        flutterToast('check_your_connection'.tr);
        return null;
      }
    } catch (e) {
      print("ERROR FROM API CLASS $e");
    }
  }

  static Future fileHandler({required File file}) async {
    var request = http.MultipartRequest('POST', Uri.parse(APIRoutes.imageAdd));
    var multipartFile =
        await http.MultipartFile.fromPath(file.path, path.basename(file.path));

    // add file to multipart
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
  }
}
