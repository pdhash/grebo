import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddServicesModel {
  final String image, title;

  AddServicesModel({required this.image, required this.title});
}

class AddServiceController extends GetxController {
  List<TextEditingController> textControllers = <TextEditingController>[];
  List<AddServicesModel> serviceMultiFile = [];

  void addDetails(String str, String image) {
    serviceMultiFile.add(AddServicesModel(image: image, title: str));
    update();
  }

  bool _addServiceBox = false;

  bool get addServiceBox => _addServiceBox;

  set addServiceBox(bool value) {
    _addServiceBox = value;
    update();
  }

  int _defaultField = 1;

  int get defaultField => _defaultField;

  set defaultField(int value) {
    _defaultField = value;
    update();
  }
}
