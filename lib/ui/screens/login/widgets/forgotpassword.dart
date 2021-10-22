import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/extension/customButtonextension.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/login/controller/forgotPasswordController.dart';
import 'package:grebo/ui/shared/appbar.dart';
import 'package:grebo/ui/shared/custombutton.dart';
import 'package:grebo/ui/shared/customtextfield.dart';

class ForgotPassword extends StatelessWidget {
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disposeKeyboard();
      },
      child: Scaffold(
        appBar: appBar('forgot_password'.tr),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      CustomTextField(
                        controller: forgotPasswordController.email,
                        hintText: 'email_example'.tr,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      getHeightSizedBox(h: 50),
                      CustomButton(
                          type: CustomButtonType.colourButton,
                          text: 'submit'.tr,
                          onTap: () {
                            disposeKeyboard();
                            forgotPasswordController.userForgotPassword();
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
      ),
    );
  }
}
