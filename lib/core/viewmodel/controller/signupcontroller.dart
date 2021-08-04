import 'package:get/get.dart';

class SignUpController extends GetxController {
  RxBool showText = true.obs;

  bool _emailVer = true;

  bool get emailVer => _emailVer;

  set emailVer(bool value) {
    _emailVer = value;
    update();
  }
}
