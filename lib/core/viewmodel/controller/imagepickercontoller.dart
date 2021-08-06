import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  String? _image;
  String? get image => _image;
  set image(String? value) {
    _image = value;
    update();
  }

  // RxList<XFile>? multiFile = <XFile>[].obs;
  // List<Asset> _images = <Asset>[];
  //
  // List<Asset> get images => _images;
  //
  // set images(List<Asset> value) {
  //   _images = value;
  //   update();
  // }
}

class AppImagePicker {
  ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  ImagePicker imagePicker = ImagePicker();
  // Future<void> loadAssets({String? actionBatTitle, String? appBarColor}) async {
  //   print('ghell');
  //   List<Asset> resultList = <Asset>[];
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 10,
  //       enableCamera: true,
  //       selectedAssets: imagePickerController.images,
  //       cupertinoOptions: CupertinoOptions(
  //         takePhotoIcon: "chat",
  //         doneButtonTitle: "Fatto",
  //       ),
  //       materialOptions: MaterialOptions(
  //         actionBarColor: appBarColor,
  //         actionBarTitle: actionBatTitle,
  //         allViewTitle: "All Photos",
  //         useDetailsView: true,
  //         selectCircleStrokeColor: "#000000",
  //       ),
  //     );
  //   } on Exception catch (e) {
  //     print(e);
  //   }

  //   imagePickerController.images = resultList;
  // }

  browseImage(ImageSource imageSource, bool isMulti) async {
    if (isMulti == true) {
      // List<XFile>? multiPickedFile =
      //     await imagePicker.pickMultiImage(imageQuality: 50);
      // imagePickerController.multiFile!.value = multiPickedFile!;
    } else {
      var pickedFile =
          await imagePicker.pickImage(source: imageSource, imageQuality: 50);

      // File? file = await ImageCropper.cropImage(
      //   sourcePath: pickedFile!.path,
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   compressFormat: ImageCompressFormat.jpg,
      //   compressQuality: 100,
      //   maxHeight: 700,
      //   maxWidth: 700,
      //   androidUiSettings: AndroidUiSettings(
      //     toolbarColor: Colors.white,
      //     toolbarTitle: "Image Cropper",
      //   ),
      // );
      imagePickerController.image = pickedFile!.path;
    }
  }

  void openBottomSheet(
      {required BuildContext context, required bool multiple}) {
    if (Platform.isIOS)
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: Text(
                'Camera',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                browseImage(ImageSource.camera, multiple);
                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                browseImage(ImageSource.gallery, multiple);
                Get.back();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      );
    else
      Get.bottomSheet(
        Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Photo Library'),
                tileColor: Colors.white,
                onTap: () async {
                  browseImage(ImageSource.gallery, multiple);
                  Get.back();

                  /*
                  var status = await Permission.photos.status;
                  print("STATUS ${status}");
                  // try {
                  if (status == PermissionStatus.denied) {
                    print("DENIED");
                    askPermissionAgain(Permission.photos);
                  } else if (status == PermissionStatus.permanentlyDenied) {
                    await openAppSettings();
                  } else if (status == PermissionStatus.granted ||
                      status == PermissionStatus.limited) {
                    print("GRNATED");
                    browseImage(ImageSource.gallery);
                  } else {
                    showMessage("restrictedAccessMsg".tr);
                  }
                 */
                },
              ),
              Divider(
                height: 0.5,
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                tileColor: Colors.white,
                onTap: () async {
                  Get.back();
                  browseImage(ImageSource.camera, multiple);

                  /*
                  var status = await Permission.camera.status;
                  print("STATUS ${status}");
                  // try {
                  if (status == PermissionStatus.denied) {
                    askPermissionAgain(Permission.camera);
                  } else if (status == PermissionStatus.permanentlyDenied) {
                    await openAppSettings();
                  } else if (status == PermissionStatus.granted ||
                      status == PermissionStatus.limited) {
                    browseImage(ImageSource.camera);
                  } else {
                    showMessage("restrictedAccessMsg".tr);
                  }
                   */
                },
              ),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.3),
      );
  }
}
