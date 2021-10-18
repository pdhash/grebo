import 'dart:io';

import 'package:get/get.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/imageRepo.dart';
import 'package:grebo/ui/global.dart';
import 'package:grebo/ui/screens/editBusinessprofile/model/addSeviceModel.dart';
import 'package:grebo/ui/screens/editBusinessprofile/model/serviceListModel.dart';
import 'package:grebo/ui/screens/editBusinessprofile/widgets/addServiceView.dart';

class AddServiceController extends GetxController {
  List<AddServiceView> addServiceViews = [];

  List<AddServicesModel> serviceMultiFile = [];

  addDefault() {
    if (serviceMultiFile.length == 0) {
      addServiceViews = [AddServiceView(index: 0)];
      serviceMultiFile = <AddServicesModel>[AddServicesModel()];
    }
  }

  bool validateForm() {
    for (int i = 0; i < serviceMultiFile.length; i++) {
      var element = serviceMultiFile[i];
      if (element.image == null ||
          element.title == null ||
          element.title!.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  add() {
    bool flag = validateForm();
    if (flag) {
      addServiceViews.add(AddServiceView(index: addServiceViews.length));
      serviceMultiFile.add(AddServicesModel());
    } else
      print('not valid');
    update();
  }

  remove(int index) {
    serviceMultiFile.removeAt(index);
    addServiceViews.removeAt(index);

    addServiceViews.asMap().forEach((int index, AddServiceView view) {
      view.index = index;
    });

    update();
  }

  Future<dynamic> submitAllFields() async {
    print(serviceMultiFile.map((e) => e.isEdit));

    if (validateForm()) {
      List<Map<String, dynamic>> uploadData = [];
      uploadData.clear();
      for (int i = 0; i < serviceMultiFile.length; i++) {
        var v = await ImageRepo.uploadImage(
            fileImage: [serviceMultiFile[i].image as File]);
        if (v != null) {
          uploadData
              .add({"image": v["data"], "name": serviceMultiFile[i].title});
        }
      }
      print(uploadData);
      appImagePicker.imagePickerController.resetImage();
      var v = await EditProfileRepo.serviceUpdate(
        map: {"services": uploadData},
      );

      return v;
    }
  }

  Future getAllServices() async {
    var v = await EditProfileRepo.getServices().then((value) {
      if (value != null) {
        addServiceViews.clear();
        serviceMultiFile.clear();
        List<Ser> services = ServiceListModel.fromJson(value).data;
        services.forEach((element) {
          Future.delayed(Duration(milliseconds: 200), addData(element));
        });
        update();
      }
    });
    if (v != null) {
      return true;
    }
  }

  addData(Ser element) {
    addServiceViews.add(
        AddServiceView(index: addServiceViews.length, serviceModel: element));
    serviceMultiFile
        .add(AddServicesModel(title: element.name, url: element.image));
  }

  @override
  void onInit() {
    getAllServices();
    super.onInit();
  }
}
