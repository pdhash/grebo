import 'dart:io';

import '../apiHandler.dart';

class ImageRepo {
  static Future businessData({
    required File file,
  }) async {
    var responseBody = await API.fileHandler(file: file);
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }
}
