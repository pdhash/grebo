import 'package:grebo/main.dart';

import '../apiHandler.dart';
import '../apiRoutes.dart';

class ContactRepo {
  static Future adminContact({
    required String helpText,
  }) async {
    var responseBody = await API.apiHandler(
        url: APIRoutes.contactAdmin,
        body: {"message": helpText},
        header: {"Authorization": userController.userToken});
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }

  static Future aboutTheApp() async {
    var responseBody =
        await API.apiHandler(url: APIRoutes.appData, showLoader: false);
    if (responseBody != null)
      return responseBody;
    else
      return null;
  }
}
