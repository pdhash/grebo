import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostController extends GetxController {
  String? _image;
  String? get image => _image;
  set image(String? value) {
    _image = value;
    update();
  }

  browseImage(ImageSource imageSource, bool isVideo) async {
    if (isVideo) {
    } else {
      ImagePicker imagePicker = ImagePicker();
      var pickedFile =
          await imagePicker.pickImage(source: imageSource, imageQuality: 50);

      image = pickedFile!.path;
    }
  }

  void openBottomSheet({required BuildContext context, required bool isVideo}) {
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
                browseImage(ImageSource.camera, isVideo);

                Get.back();
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                browseImage(ImageSource.gallery, isVideo);

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
                  browseImage(ImageSource.gallery, isVideo);
                  Get.back();
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
                  browseImage(ImageSource.camera, isVideo);
                },
              ),
            ],
          ),
        ),
        barrierColor: Colors.black.withOpacity(0.3),
      );
  }
}
