import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/addservicecontroller.dart';
import 'package:grebo/ui/shared/alertdialogue.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';

import '../mainscreen.dart';
import 'details1.dart';

class DetailsPage3 extends StatelessWidget {
  final bool isShow;
  final AddServiceController addServiceController =
      Get.put(AddServiceController());

  DetailsPage3({Key? key, this.isShow = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    addServiceController.addDefault();
    return Scaffold(
        appBar: appBar(
          'add_services_offered'.tr,
          [
            isShow
                ? Padding(
                    padding: const EdgeInsets.only(top: 22, right: 25),
                    child: Text(
                      '3 of 3',
                      style: TextStyle(
                          color: AppColor.kDefaultFontColor.withOpacity(0.72),
                          fontSize: 15),
                    ),
                  )
                : SizedBox()
          ],
        ),
        body: GetBuilder<AddServiceController>(
          builder: (controller) {
            return Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: List.generate(
                            controller.serviceMultiFile.length, (index) {
                          return controller.addServiceViews[index];
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding),
                        child: GestureDetector(
                          onTap: () {
                            controller.add();
                            disposeKeyboard();
                          },
                          child: header('add_more_service'.tr),
                        ),
                      ),
                      getHeightSizedBox(h: 100)
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30)
                            .copyWith(top: 10, bottom: 10),
                        child: CustomButton(
                            type: CustomButtonType.colourButton,
                            text: isShow ? 'submit'.tr : 'save'.tr,
                            onTap: () {
                              if (isShow) {
                                showCustomDialog(
                                    context: context,
                                    content: 'dialogue_msg'.tr,
                                    contentSize: 15,
                                    onTap: () {
                                      Get.offAll(() => HomeScreen());
                                    },
                                    color: AppColor.kDefaultColor,
                                    okText: 'ok'.tr);
                              }
                              disposeKeyboard();
                            }),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
