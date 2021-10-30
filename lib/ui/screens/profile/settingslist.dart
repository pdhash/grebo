import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grebo/core/constants/appSetting.dart';
import 'package:grebo/core/constants/appcolor.dart';
import 'package:grebo/core/utils/config.dart';
import 'package:grebo/ui/screens/profile/controller/aboutUsController.dart';
import 'package:grebo/ui/shared/appbar.dart';

enum DescriptionScreen { aboutUs, termsAndConditions }

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
      appBar: appBar(DescriptionScreen.aboutUs == widget.screenType
          ? 'about_us'.tr
          : 'terms_and_conditions'.tr),
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
                      DescriptionScreen.aboutUs == widget.screenType
                          ? aboutUsController.aboutUs.toString()
                          : aboutUsController.tc.toString(),
                      style: TextStyle(
                          height: 1.3,
                          color: AppColor.kDefaultFontColor.withOpacity(0.81),
                          fontSize: getProportionateScreenWidth(15)),
                    ),
                  ),
      ),
    );
  }
}
