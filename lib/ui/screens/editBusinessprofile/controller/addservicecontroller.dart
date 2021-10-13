import 'dart:io';

import 'package:get/get.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/imageRepo.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/ui/screens/editBusinessprofile/controller/availabilitycontroller.dart';
import 'package:grebo/ui/screens/editBusinessprofile/controller/editprofilecontroller.dart';
import 'package:grebo/ui/screens/editBusinessprofile/model/addSeviceModel.dart';
import 'package:grebo/ui/screens/editBusinessprofile/widgets/addServiceView.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

class AddServiceController extends GetxController {
  late EditBProfileController editBProfileController;
  late AvailabilityController availabilityController;

  AddServiceController() {
    editBProfileController = Get.find<EditBProfileController>();
    availabilityController = Get.find<AvailabilityController>();
  }

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
    //addServiceViews[index].appImagePicker.imagePickerController.resetImage();
    serviceMultiFile.removeAt(index);
    addServiceViews.removeAt(index);

    addServiceViews.asMap().forEach((int index, AddServiceView view) {
      view.index = index;
    });

    update();
  }

  Future<dynamic> submitAllFields() async {
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
      var v = await EditProfileRepo.updateUser(
        map: {"services": uploadData},
      );
      if (v != null) {
        updateUserDetail(User.fromJson(v['data']));
      }
      return v;
    }
  }
}
