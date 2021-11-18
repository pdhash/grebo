import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/profile/controller/aboutUsController.dart';
import 'package:grebo/ui/shared/appbar.dart';

enum DescriptionScreen { aboutUs, termsAndConditions, privacyPolicy }

class AboutUsAndTAndC extends StatefulWidget {
  final DescriptionScreen screenType;

  const AboutUsAndTAndC({Key? key, required this.screenType}) : super(key: key);

  @override
  _AboutUsAndTAndCState createState() => _AboutUsAndTAndCState();
}

class _AboutUsAndTAndCState extends State<AboutUsAndTAndC> {
  final AboutUsController aboutUsController = Get.put(AboutUsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: getAppTitle()),
      body: GetBuilder(
        builder: (AboutUsController controller) =>
            controller.aboutUs == null && controller.tc == null
                ? Center(
                    child: GetPlatform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding)
                            .copyWith(top: 5),
                    child: Text(
                      desc(),
                      style: TextStyle(
                          height: 1.3,
                          color: AppColor.kDefaultFontColor.withOpacity(0.81),
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                  ),
      ),
    );
  }

  String getAppTitle() {
    switch (widget.screenType) {
      case DescriptionScreen.aboutUs:
        return 'about_us'.tr;
      case DescriptionScreen.termsAndConditions:
        return 'terms_and_conditions'.tr;
      case DescriptionScreen.privacyPolicy:
        return 'privacy_policy'.tr;
    }
  }

  String desc() {
    switch (widget.screenType) {
      case DescriptionScreen.aboutUs:
        return aboutUsController.aboutUs.toString();
      case DescriptionScreen.termsAndConditions:
        return aboutUsController.tc.toString();
      case DescriptionScreen.privacyPolicy:
        return aboutUsController.privacyPolicy.toString();
    }
  }
}
