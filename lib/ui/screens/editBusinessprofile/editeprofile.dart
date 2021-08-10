import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/editprofilecontroller.dart';
import 'package:greboo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/shared/appbar.dart';

class EditBusinessProfile extends StatelessWidget {
  final EditBProfileController editProfileController =
      Get.put(EditBProfileController());
  final ImagePickerController imagePickerController = ImagePickerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('business_details'.tr, [
        MaterialButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: GetBuilder(
              builder: (EditBProfileController controller) {
                return Text(
                  // '${controller.currentPage + 1} of 3',
                  '${controller.imageList!.length}',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.72),
                      fontSize: getProportionateScreenWidth(15)),
                );
              },
            ),
          ),
        )
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.8,
                child: GetBuilder(
                  builder: (EditBProfileController controller) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 100 / 80),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) =>
                            controller.imageList!.length > (index - 0)
                                ? Image.file(File(controller.imageList![index]))
                                : GestureDetector(
                                    onTap: () {
                                      controller.openBottomSheet(
                                          context: context,
                                          isVideo: false,
                                          index: index);
                                    },
                                    child: buildWidget(
                                        AppImages.uploadImage, 80, 100)));
                  },
                ),
              ),
              GestureDetector(
                  onTap: () {
                    print(editProfileController.imageList![1]);
                  },
                  child: Text('ok'))
            ],
          ),
        ),
      ),
    );
  }
}
