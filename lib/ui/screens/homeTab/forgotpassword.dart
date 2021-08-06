import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/shared/alertdialogue.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/customtextfield.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('forgot_password'.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height / 1.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'enter_your_email..'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(20)),
                    ),
                    getHeightSizedBox(h: 39),
                    Text(
                      'e_mail'.tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(16)),
                    ),
                    CustomTextField(
                      controller: email,
                      hintText: 'email_example'.tr,
                    ),
                    getHeightSizedBox(h: 50),
                    CustomButton(
                        type: CustomButtonType.colourButton,
                        text: 'submit'.tr,
                        onTap: () {
                          showCustomDialog(
                              context: context,
                              color: AppColor.kDefaultColor,
                              content: Text(
                                'a_link_to..'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: getProportionateScreenWidth(16)),
                              ),
                              okText: 'save'.tr,
                              onTap: () {
                                Get.back();
                              },
                              height: getProportionateScreenWidth(180));
                        }),
                    getHeightSizedBox(h: 70)
                  ],
                ),
              ),
              Container(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
