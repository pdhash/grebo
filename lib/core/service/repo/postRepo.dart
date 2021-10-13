import 'package:grebo/core/service/apiHandler.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';

class PostRepo {
  static Future<PostModel?> fetchMyPost() async {
    var response = await API.apiHandler(
        url: APIRoutes.myPost,
        showLoader: false,
        header: {"Authorization": userController.userToken});
    if (response != null) {
      return PostModel.fromJson(response);
    } else
      return null;
  }
  // static Future<PostModel?> fetchAllPost() async {
  //   var response = await API.apiHandler(
  //       url: APIRoutes.a,
  //       showLoader: false,
  //       header: {"Authorization": userController.userToken});
  //   if (response != null) {
  //     return PostModel.fromJson(response);
  //   } else
  //     return null;
  // }
}
