import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/viewmodel/controller/imagepickercontoller.dart';

class AddServicesModel {
  final String? image;
  final String? title;

  AddServicesModel({required this.image, this.title});
}

class AddServiceController extends GetxController {
  ImagePickerController imagePickerController =
      Get.find<ImagePickerController>();
  List<TextEditingController> textControllers = <TextEditingController>[];
  List<AddServicesModel> serviceMultiFile = <AddServicesModel>[];

  addDetails(index) {
    serviceMultiFile.add(AddServicesModel(
      image: imagePickerController.image.toString(),
    ));
    update();
  }

  int _defaultField = 1;

  int get defaultField => _defaultField;

  set defaultField(int value) {
    _defaultField = value;
    update();
  }
}
