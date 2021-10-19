import 'dart:io';

import 'package:get/get.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/imageRepo.dart';
import 'package:grebo/ui/screens/editBusinessprofile/model/addSeviceModel.dart';
import 'package:grebo/ui/screens/editBusinessprofile/model/serviceListModel.dart';
import 'package:grebo/ui/screens/editBusinessprofile/widgets/addServiceView.dart';

class AddServiceController extends GetxController {
  List<AddServiceView> addServiceViews = [];

  List<AddServicesModel> addServiceModels = [];

  addDefault() {
    print("ADD DEFAULT");
    if (addServiceModels.length == 0) {
      addServiceViews = [AddServiceView(index: 0)];
      addServiceModels = <AddServicesModel>[AddServicesModel()];
    }
  }

  bool validateForm() {
    for (int i = 0; i < addServiceModels.length; i++) {
      var element = addServiceModels[i];
      if (element.image == null ||
          element.title == null ||
          element.title!.trim().isEmpty) {
        print("validateForm FALSE");
        return false;
      }
    }
    print("validateForm TRUE");
    return true;
  }

  add() {
    print("ADD at ${addServiceViews.length}");
    bool flag = validateForm();
    if (flag) {
      addServiceViews.add(AddServiceView(index: addServiceViews.length));
      addServiceModels.add(AddServicesModel());
    } else
      print('not valid');
    update();
  }

  remove(int index) {
    print("REMOVE at ${index}");
    addServiceModels.removeAt(index);
    addServiceViews.removeAt(index);
    addServiceViews.asMap().forEach((int index, AddServiceView view) {
      view.index = index;
    });

    update();
  }

  Future<dynamic> submitAllFields() async {
    if (validateForm()) {
      List<Map<String, dynamic>> uploadData = [];
      for (int i = 0; i < addServiceModels.length; i++) {
        if (addServiceModels[i].url != "") {
          uploadData.add({
            "image": addServiceViews[i].serviceModel!.image,
            "name": addServiceModels[i].title
          });
        } else {
          var v = await ImageRepo.uploadImage(
              fileImage: [addServiceModels[i].image as File]);
          if (v != null) {
            uploadData
                .add({"image": v["data"], "name": addServiceModels[i].title});
          }
        }
      }
      print("serviceUpdate ${uploadData.length}");
      var v = await EditProfileRepo.serviceUpdate(
        map: {"services": uploadData},
      );

      return v;
    }
  }

  Future getAllServices() async {
    await EditProfileRepo.getServices().then((value) {
      if (value != null) {
        List<Ser> services = ServiceListModel.fromJson(value).data;
        if (services.isNotEmpty) {
          addServiceViews.clear();
          addServiceModels.clear();
          services.forEach((element) {
            Future.delayed(Duration(milliseconds: 20), addData(element));
          });
          update();
        } else {
          addDefault();
        }
      }
    });
  }

  addData(Ser element) {
    addServiceViews.add(
        AddServiceView(index: addServiceViews.length, serviceModel: element));
    addServiceModels
        .add(AddServicesModel(title: element.name, url: element.image));
  }

  @override
  void onInit() {
    getAllServices();
    super.onInit();
  }
}
