import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/shared/alertdialogue.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/postview.dart';

class GiveFeedback extends StatelessWidget {
  final AppImagePicker appImagePicker = AppImagePicker();
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('give_feedback'.tr),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildCircleProfile(
                  image: AppImages.defaultProfile, height: 95, width: 95),
              getHeightSizedBox(h: 21),
              Text(
                'how_was..'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getProportionateScreenWidth(16)),
              ),
              getHeightSizedBox(h: 13),
              Text(
                'your_feedback..'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    color: AppColor.kDefaultFontColor.withOpacity(0.77)),
              ),
              getHeightSizedBox(h: 17),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                glow: false,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 33,
                unratedColor: Color(0xffE8E8E8),
                itemPadding: EdgeInsets.only(right: 5.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xffFAAA01),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              getHeightSizedBox(h: 20),
              Divider(
                thickness: 1,
                height: 0,
                color: AppColor.kDefaultFontColor.withOpacity(0.09),
              ),
              getHeightSizedBox(h: 28),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'write_your..'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(16)),
                    ),
                    getHeightSizedBox(h: 16),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                      style: TextStyle(
                          color: Color(0xff585757),
                          fontSize: getProportionateScreenWidth(14)),
                    ),
                    getHeightSizedBox(h: 10),
                    Divider(
                      thickness: 1,
                      height: 0,
                      color: AppColor.kDefaultFontColor.withOpacity(0.09),
                    ),
                    getHeightSizedBox(h: 16),
                    Text(
                      'upload_photo'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(16)),
                    ),
                    getHeightSizedBox(h: 16),
                  ],
                ),
              ),
              GetBuilder(
                builder: (ImagePickerController controller) => MaterialButton(
                  onPressed: () {
                    appImagePicker.openBottomSheet(
                        context: context, multiple: false);
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 130,
                    width: Get.width,
                    margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0xff747474).withOpacity(0.26), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: controller.image == null
                        ? Column(
                            children: [
                              Spacer(),
                              buildWidget(AppImages.uploadReview, 30, 32),
                              getHeightSizedBox(h: 13),
                              Text(
                                'click_here'.tr,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(14)),
                              ),
                              Spacer(),
                            ],
                          )
                        : Stack(
                            clipBehavior: Clip.antiAlias,
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(controller.image.toString()),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                  right: -10,
                                  top: -10,
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.image = null;
                                      },
                                      child:
                                          buildWidget(AppImages.close, 29, 29)))
                            ],
                          ),
                  ),
                ),
              ),
              getHeightSizedBox(h: 87),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: CustomButton(
                    type: CustomButtonType.colourButton,
                    text: 'submit'.tr,
                    onTap: () {
                      showCustomDialog(
                          context: context,
                          height: 150,
                          content: Text(
                            'submitting_review'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(18)),
                          ),
                          color: AppColor.kDefaultColor,
                          okText: 'ok'.tr,
                          onTap: () {
                            Get.back();
                          });
                    }),
              ),
              getHeightSizedBox(h: 30),
            ],
          ),
        ),
      ),
    );
  }
}
