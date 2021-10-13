import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

class ServiceOfferedController {
  late bool isNextPost;
  ServiceOfferedController() {
    isNextPost = true;
  }
  Future<List<ServiceList>> getServices(int offset) async {
    if (offset == 0) isNextPost = true;
    if (isNextPost == false) return [];
    List<ServiceList> allServices = [];
    var request = await EditProfileRepo.getServices();
    allServices =
        List.from(request["data"].map((x) => ServiceList.fromJson(x)));
    isNextPost = request["hasMore"];
    return allServices;
  }
}
