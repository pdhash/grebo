import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greboo/core/constants/appSetting.dart';
import 'package:greboo/core/constants/appcolor.dart';
import 'package:greboo/core/extension/customButtonextension.dart';
import 'package:greboo/core/utils/config.dart';
import 'package:greboo/ui/shared/alertdialogue.dart';
import 'package:greboo/ui/shared/appbar.dart';
import 'package:greboo/ui/shared/custombutton.dart';

enum DescriptionScreen { aboutUs, termsAndConditions }

class AboutUsAndTAndC extends StatelessWidget {
  final DescriptionScreen screenType;

  const AboutUsAndTAndC({Key? key, required this.screenType}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(DescriptionScreen.aboutUs == screenType
          ? 'about_us'.tr
          : 'terms_and_conditions'.tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding)
            .copyWith(top: 5),
        child: Text(
          DescriptionScreen.aboutUs == screenType
              ? 'aboutusdes'.tr
              : 'termsandconditiondes'.tr,
          style: TextStyle(
              color: AppColor.kDefaultFontColor.withOpacity(0.81),
              fontSize: getProportionateScreenWidth(15)),
        ),
      ),
    );
  }
}

class ContactAdmin extends StatelessWidget {
  const ContactAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('contact_admin'.tr),
      body: SingleChildScrollView(
          child: Column(
        children: [
          getHeightSizedBox(h: 10),
          Container(
            height: 187,
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xffC4C4C4))),
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15),
                  hintText: 'how_can_we_help'.tr,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: AppColor.kDefaultFontColor,
                      fontSize: getProportionateScreenWidth(16))),
            ),
          ),
          getHeightSizedBox(h: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: CustomButton(
                type: CustomButtonType.colourButton,
                text: 'save'.tr,
                onTap: () {
                  showCustomDialog(
                      context: context,
                      height: 150,
                      content: Text(
                        'dialog_msg'.tr,
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(15)),
                      ),
                      onTap: () {},
                      color: AppColor.kDefaultColor,
                      okText: 'ok'.tr);
                }),
          )
        ],
      )),
    );
  }
}

class Faqs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('faqs'.tr),
    );
  }
}
