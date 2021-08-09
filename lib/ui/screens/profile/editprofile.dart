import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/screens/homeTab/home.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/customtextfield.dart';

class EditProfile extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
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
                Text(
                  'location'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                CustomTextField(
                  controller: email,
                  hintText: 'johnsmith@gmail.com',
                  suffix: IconButton(
                    icon: buildWidget(AppImages.gps, 21, 21),
                    onPressed: () {},
                  ),
                ),
                getHeightSizedBox(h: 250),
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
