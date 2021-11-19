import 'package:get/get.dart';
import 'package:grebo/core/service/repo/contactRepo.dart';

class AboutUsController extends GetxController {
  String? aboutUs;
  String? tc;
  String? privacyPolicy;

  Future aboutTheApp() async {
    var response = await ContactRepo.aboutTheApp();
    if (response != null) {
      aboutUs = response["data"]["aboutUs"];
      tc = response["data"]["termsAndConditions"];
      privacyPolicy = response["data"]["privacyPolicy"];
      update();
    }
  }

  @override
  void onInit() {
    aboutTheApp();
    super.onInit();
  }
}
