import 'package:get/get.dart';

class BaseController extends GetxController {
  int _current = 0;

  int get currentTab => _current;

  set currentTab(int value) {
    _current = value;
    update();
  }
}
