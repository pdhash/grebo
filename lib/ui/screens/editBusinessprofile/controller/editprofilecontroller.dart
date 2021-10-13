import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/models/countrymodel.dart';
import 'package:grebo/core/service/repo/editProfileRepo.dart';
import 'package:grebo/core/service/repo/imageRepo.dart';
import 'package:grebo/core/utils/appFunctions.dart';
import 'package:grebo/core/utils/sharedpreference.dart';
import 'package:grebo/main.dart';
import 'package:grebo/ui/screens/login/model/currentUserModel.dart';

import '../../../global.dart';
import '../details 2.dart';

class EditBProfileController extends GetxController {
  EditBProfileController() {}
  final TextEditingController businessName = TextEditingController();
  final TextEditingController businessCategory = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController weblinks = TextEditingController();

  late CountryModel _selectedCountry;
  CountryModel get selectedCountry => _selectedCountry;
  set selectedCountry(CountryModel value) {
    _selectedCountry = value;
    update();
  }

  List<CountryModel>? _countries;
  List<CountryModel>? get countries => _countries;
  set countries(List<CountryModel>? value) {
    _countries = value;
    update();
  }

  //add websites
  List<String> websites = <String>[];
  void addWebsite(String str) {
    websites.add(str);
    update();
  }

  void removeWebsite(val) {
    websites.remove(val);
    update();
  }

  //country update
  late String _kDefaultCountry = '91';

  String get kDefaultCountry => _kDefaultCountry;

  set kDefaultCountry(String value) {
    _kDefaultCountry = value;
    update();
  }

  List<File> multiFile = <File>[];
  late List<String> uploadMultiFile;

  void removeImage(int index) {
    multiFile.removeAt(index);

    uploadMultiFile.removeAt(index);
    update();
  }

  void removeImageLocally(index) {
    uploadMultiFile.removeAt(index);
    update();
  }

  void multiAddImages(File file, String imageID) {
    multiFile.add(file);
    uploadMultiFile.add(imageID);
    update();
  }

  ///-------------------------------------------------

  String? _selectValue;

  String? get selectValue => _selectValue;

  set selectValue(String? value) {
    _selectValue = value;
    update();
  }

  int _categorySelect = 1;

  int get categorySelect => _categorySelect;

  set categorySelect(int value) {
    _categorySelect = value;
    update();
  }

  Color _defaultColor = Color(0xff8F92A3);

  Color get defaultColor => _defaultColor;

  set defaultColor(Color value) {
    _defaultColor = value;
    update();
  }

  void loadCountryJsonFile() async {
    print("loadCountryJsonFile....");
    var jsonText = await rootBundle.loadString(AppJson.country);
    countries = countryModelFromJson(jsonText);
  }

  uploadImage() {
    appImagePicker.imagePickerController.resetImage();
    appImagePicker.openBottomSheet().then((value) {
      if (appImagePicker.imagePickerController.image != null) {
        ImageRepo.uploadImage(
                fileImage: [appImagePicker.imagePickerController.image as File])
            .then((value) {
          flutterToast(value["message"]);
          multiAddImages(appImagePicker.imagePickerController.image as File,
              value["userController.user"].toString());
        });
      }
    });
  }

  deleteImage(int index) {
    ImageRepo.deleteImage(imageId: uploadMultiFile[index]).then((value) {
      flutterToast(value["message"]);
      removeImage(index);
    });
  }

  Future submitAllFields() async {
    var v = await EditProfileRepo.updateUser(
      map: {
        "name": "userName",
        "businessName": businessName.text.trim(),
        "images": uploadMultiFile,
        "latitude": 1,
        "longitude": 2,
        "categories": [userController.globalCategory[categorySelect].id],
        "websites": websites,
        "phoneCode": kDefaultCountry,
        "phoneNumber": mobileNumber.text.trim(),
        "description": description.text.trim(),
      },
    );
    if (v != null) {
      updateUserDetail(User.fromJson(v['userController.user']));

      Get.to(() => DetailsPage2());
    }
  }

  @override
  void onInit() {
    loadCountryJsonFile();
    print("image length ${userController.user.images.length}");
    if (userController.user.profileCompleted == true) {
      businessName.text = userController.user.businessName;
      mobileNumber.text = userController.user.phoneNumber;
      description.text = userController.user.description;
      uploadMultiFile = userController.user.images;
      websites = userController.user.websites;
      for (int i = 0; i < userController.user.categories.length; i++) {
        for (int j = 0; j < userController.globalCategory.length; j++) {
          if (userController.user.categories[i].id ==
              userController.globalCategory[j].id) {
            businessCategory.text = userController.globalCategory[j].name;
          }
        }
      }
    }
    super.onInit();
  }
}
