import 'package:grebo/core/service/apiHandler.dart';
import 'package:grebo/core/service/apiRoutes.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/homeTab/model/postModel.dart';

class PostRepo {
  static Future<PostModel?> fetchMyPost() async {
    var response = await API.apiHandler(
        url: APIRoutes.myPost,
        header: {"Authorization": userController.userToken});
    if (response != null) {
      print(response);
      return PostModel.fromJson(response);
    } else
      return null;
  }
}
