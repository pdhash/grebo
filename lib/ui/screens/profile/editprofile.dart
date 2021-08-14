import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/app_assets.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/core/viewmodel/controller/homescreencontroller.dart';
import 'package:grebo/core/viewmodel/controller/selectservicecontoller.dart';
import 'package:grebo/ui/screens/homeTab/home.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final HomeScreenController homeScreenController =
      Get.find<HomeScreenController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('edit_profile'.tr),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: getProportionateScreenWidth(93),
                    width: getProportionateScreenWidth(93),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(AppImages.defaultProfile))),
                  ),
                ),
                getHeightSizedBox(h: 10),
                Center(
                  child: Text(
                    'change_image'.tr,
                    style: TextStyle(fontSize: getProportionateScreenWidth(14)),
                  ),
                ),
                getHeightSizedBox(h: 30),
                Text(
                  'name'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                CustomTextField(controller: name, hintText: 'John smith'),
                getHeightSizedBox(h: 18),
                Text(
                  'email'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                CustomTextField(
                    controller: email, hintText: 'johnsmith@gmail.com'),
                getHeightSizedBox(h: 18),
                homeScreenController.serviceController.servicesType ==
                        ServicesType.userType
                    ? Column(
                        children: [
                          Text(
                            'location'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                          Get.height < 800
                              ? getHeightSizedBox(h: 10)
                              : SizedBox(),
                          CustomTextField(
                            controller: email,
                            hintText: 'johnsmith@gmail.com',
                            suffix: IconButton(
                              icon: buildWidget(AppImages.gps, 21, 21),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
                getHeightSizedBox(h: 280),
                SafeArea(
                  child: CustomButton(
                      type: CustomButtonType.colourButton,
                      text: 'save'.tr,
                      onTap: () {
                        Get.back();
                      }),
                ),
                getHeightSizedBox(h: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
