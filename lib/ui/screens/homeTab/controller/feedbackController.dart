import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/service/repo/postRepo.dart';
import 'package:grebo/ui/shared/alertdialogue.dart';

import '../../../global.dart';

class FeedbackController extends GetxController {
  String businessRef = "";
  double rating = 1;

  final TextEditingController description = TextEditingController();

  File? get image => appImagePicker.imagePickerController.image;
  resetVar() {
    appImagePicker.imagePickerController.resetImage();
    rating = 1;
    description.clear();
    update();
  }

  submitAllFields() async {
    print(businessRef);
    var v = await PostRepo.updateReview({
      "businessRef": businessRef,
      "rating": rating,
      "text": description.text.trim()
    }, image);

    if (v != null) {
      showCustomDialog(
          context: Get.context as BuildContext,
          height: 150,
          content: 'submitting_review'.tr,
          contentSize: 18,
          color: AppColor.kDefaultColor,
          okText: 'ok'.tr,
          onTap: () {
            Get.back();
            Get.back();
          });
    } else
      resetVar();
  }
}
