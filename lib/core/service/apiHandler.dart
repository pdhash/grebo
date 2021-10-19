import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/ui/shared/loader.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as mimeee;
import 'package:mime_type/mime_type.dart';

enum RequestType { Get, Post }

class API {
  static late http.Response response;

  static Future apiHandler({
    required String url,
    RequestType requestType = RequestType.Post,
    Map<String, String>? header,
    bool showLoader = true,
    dynamic body,
  }) async {
    try {
      if (await checkConnection()) {
        if (showLoader) LoadingOverlay.of().show();

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
          var res = jsonDecode(response.body);
          print("RESPONSE BODY CREATE ====== $res");

          if (showLoader) LoadingOverlay.of().hide();

          if (res["code"] == 100) {
            return res;
          } else {
            flutterToast(res["message"]);
            return null;
          }
        } else {
          if (showLoader) LoadingOverlay.of().hide();

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

  static Future multiPartAPIHandler(
      {List<File>? fileImage,
      Map<String, String>? field,
      File? thumbnail,
      bool showLoader = true,
      String multiPartImageKeyName = "image",
      Map<String, String>? header,
      required String url}) async {
    try {
      bool connection = await checkConnection();

      if (connection) {
        print("URl ===> $url");
        print("HEADER ===> $header");
        print("BODY ===> $field");
        if (showLoader) LoadingOverlay.of().show();
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(url),
        );
        if (header != null) request.headers.addAll(header);
        if (field != null) request.fields.addAll(field);

        if (fileImage != null) {
          fileImage.forEach((element) async {
            String? mimeType = mime(element.path);
            print(mimeType);
            print("VIDEO ================ ${element.path}");
            request.files.add(await http.MultipartFile.fromPath(
                multiPartImageKeyName, element.path,
                contentType: mimeee.MediaType(
                    mimeType!.split("/")[0], mimeType.split("/")[1])));
          });
        }
        if (thumbnail != null) {
          request.files.add(await http.MultipartFile.fromPath(
              "thumbnailImage", thumbnail.path));
        }

        http.StreamedResponse response = await request.send();
        var res = await response.stream.bytesToString();
        var resDecode = jsonDecode(res);
        if (resDecode["code"] == 100) {
          if (showLoader) LoadingOverlay.of().hide();

          return resDecode;
        } else {
          if (showLoader) LoadingOverlay.of().hide();
          flutterToast(resDecode["message"]);

          //return null;
        }
      } else {
        flutterToast('check_your_connection'.tr);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
