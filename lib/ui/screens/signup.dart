import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/app_assets.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/core/viewmodel/controller/signupcontroller.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';
import 'package:greboo/ui/shared/customtextfield.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (SignUpController controller) {
        if (controller.emailVer) {
          return Scaffold(
            appBar: appBar('Register'),
            body: Form(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: getProportionateScreenWidth(91),
                          width: getProportionateScreenWidth(94),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            AppImages.upload,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      getHeightSizedBox(h: 28),
                      Text(
                        'name'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      CustomTextField(
                        controller: name,
                        hintText: 'John smith',
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      getHeightSizedBox(h: 18),
                      Text(
                        'email'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          controller: email,
                          hintText: 'johnsmith@gmail.com'),
                      getHeightSizedBox(h: 18),
                      Text(
                        'password'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      Obx(() => CustomTextField(
                            controller: password,
                            suffixWidth: 40,
                            hintText: 'XXXXXXXX',
                            keyboardType: TextInputType.visiblePassword,
                            obSecureText: signUpController.showText.value,
                            suffix: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                signUpController.showText.toggle();
                              },
                              icon: Text(
                                signUpController.showText.value
                                    ? 'show'.tr
                                    : 'hide'.tr,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      getHeightSizedBox(h: 18),
                      Text(
                        'confirm_password'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(16)),
                      ),
                      Get.height < 800 ? getHeightSizedBox(h: 10) : SizedBox(),
                      Obx(
                        () => CustomTextField(
                          controller: confirmPassword,
                          hintText: 'XXXXXXXX',
                          suffixWidth: 40,
                          keyboardType: TextInputType.visiblePassword,
                          obSecureText: signUpController.showText2.value,
                          suffix: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              signUpController.showText2.toggle();
                            },
                            icon: Text(
                              signUpController.showText2.value
                                  ? 'show'.tr
                                  : 'hide'.tr,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      getHeightSizedBox(h: 170),
                      CustomButton(
                          type: CustomButtonType.colourButton,
                          text: 'Signup'.tr,
                          onTap: () {
                            controller.emailVer = false;
                          }),
                      getHeightSizedBox(h: 18),
                      Center(
                        child: RichText(
                            text: TextSpan(
                                children: [
                              TextSpan(
                                  text: 'login'.tr,
                                  style: TextStyle(
                                      fontFamily: 'Nexa',
                                      color: AppColor.kDefaultFontColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenWidth(15)))
                            ],
                                text: 'already_have'.tr,
                                style: TextStyle(
                                    fontFamily: 'Nexa',
                                    color: AppColor.kDefaultFontColor
                                        .withOpacity(0.4),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        getProportionateScreenWidth(15)))),
                      ),
                      getHeightSizedBox(h: 40)
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: getProportionateScreenWidth(171),
                    width: getProportionateScreenWidth(171),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      AppImages.emailVer,
                      fit: BoxFit.fill,
                    ),
                  ),
                  getHeightSizedBox(h: 28),
                  Text(
                    'email_verify..'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(20)),
                  ),
                  getHeightSizedBox(h: 26),
                  CustomButton(
                      type: CustomButtonType.colourButton,
                      text: 'ok'.tr,
                      onTap: () {
                        Get.back();

                        controller.emailVer = true;
                      }),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
