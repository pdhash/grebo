import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/editprofilecontroller.dart';
import 'package:greboo/core/viewmodel/controller/imagepickercontoller.dart';
import 'package:greboo/ui/shared/appbar.dart';

import 'details 2.dart';
import 'details1.dart';
import 'details3.dart';

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
                    '${controller.currentPage + 1} of 3',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.72),
                        fontSize: getProportionateScreenWidth(15)),
                  );
                },
              ),
            ),
          )
        ]),
        body: GetBuilder(
          builder: (EditBProfileController controller) {
            return PageView(
              controller: controller.pageController,
              //physics: NeverScrollableScrollPhysics(),
              onPageChanged: (val) => controller.currentPage = val,
              children: [
                DetailsPage1(),
                DetailsPage2(),
                DetailsPage3(),
              ],
            );
          },
        ));
  }
}
